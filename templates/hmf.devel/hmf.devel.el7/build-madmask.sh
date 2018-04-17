#!/bin/bash

## --------------------------------------
##  HappyFace-MadMask development env
## --------------------------------------

## Wait due to the loads of the other Docker VMs
sleep 60

## Changing ownership of Docker volume dirs to the HappyFace user.
chown happyface3:happyface3 /var/lib/MadMaskData/*
chown -R root:root /root/.ssh 


## Building and Installing HappyFace-MadMask
pushd /devel/HappyFace-MadMask
./rebuild.sh -p
#./rebuild.sh -b madmask
./rebuild.sh -b devel
./rebuild.sh -b madmodules
./rebuild.sh -b madfoxd
./rebuild.sh -b rlibs
./rebuild.sh -b android-sdk
./rebuild.sh -t
popd


## Getting the site name
SITE_NAME=$(ls /sites | grep -v default | head -n 1)
echo "Site = [$SITE_NAME]"

## Changing Site directory in MadMask
[ ! -e /sites/default ] && ln -vs $SITE_NAME /sites/default
MADMASK_HOME=/var/lib/HappyFace3/MadMask
echo "Applying a site configuration to [$MADMASK_HOME] in this container ..."
[ ! -L  $MADMASK_HOME/sites ] && mv -v $MADMASK_HOME/sites $MADMASK_HOME/sites.org
ln -vs /sites $MADMASK_HOME/sites


## Building the Android application
echo "Building the Android APKs ..."
rsync -avlogp /usr/local/android-tools/.android $MADMASK_HOME/

## Changing ownership of Android SDK and updating it
if [ "$SITE_NAME" == "ADC" ]; then
    chown -R happyface3:happyface3 /usr/local/android-tools
    su - happyface3 -c ". /etc/profile; setup_android_sdk; update-android-sdk"
    rsync -avlogp --delete $MADMASK_HOME/../.android /usr/local/android-tools/

    ## Building the mobile application in a backgroud process
    su - happyface3 -c ". /etc/profile; setup_android_sdk; $MADMASK_HOME/madmask -b &> /tmp/madmask.android-build.log &"
fi


## Changing configurations in HappyFace MadModules




## Starting MadFoxd & MadMaskd (Ionic Mobile Server)
echo "Enabling MadMask and MadFox daemons"
systemctl enable madmaskd.service
systemctl enable madfoxd.service
systemctl enable crond.service
systemctl enable sshd.service
systemctl enable httpd.service


##  Done!! 
exec /usr/sbin/init

