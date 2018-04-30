#!/bin/bash

## --------------------------------------
##  HappyFace-MadMask development env
## --------------------------------------

## Wait due to the loads of the other Docker VMs
echo "$(date): Waiting ..."
sleep 60

## Changing ownership of Docker volume dirs to the HappyFace user.
chown happyface3:happyface3 /var/lib/MadMaskData/*
chown -R happyface3:happyface3 /firefox
chown -R root:root /root/.ssh 



## Building and Installing HappyFace-MadMask
pushd /devel/HappyFace-MadMask
./rebuild.sh -p
./rebuild.sh -b hf
./rebuild.sh -b hf_atlas
[ -z "$MADMASK_DEVEL" ] && ./rebuild.sh -b madmask
[ ! -z "$MADMASK_DEVEL" ] && ./rebuild.sh -b devel
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


## For development env (Note: Remove this later)
## Rebuilding node-sass to HFMobile again, due to a native hardware or vender issue 
if [ ! -z "$MADMASK_DEVEL" ]; then
    echo "Reinstalling node-sass to [$MADMASK_HOME/node_modules] again ..."
    su - happyface3 -c "cd $MADMASK_HOME && npm rebuild node-sass --force"
fi


## Building the Android application packages
if [ "$SITE_NAME" == "ADC" ]; then
    ANDROID_TOOLS=/usr/local/android-tools

    echo "Copying the Android APKs cache ..."
    rsync -alogp $ANDROID_TOOLS/.android $MADMASK_HOME/

    chown -R happyface3:happyface3 $ANDROID_TOOLS
    su - happyface3 -c ". /etc/profile; setup_android_sdk; update-android-sdk"
    rsync -alogp --delete $MADMASK_HOME/../.android $ANDROID_TOOLS

    ## Building the mobile application in a backgroud process
    BUILD_HOME=/tmp/HappyFaceMobile-build
    echo "Copying HappyFaceMobile from [$MADMASK_HOME] to [$BUILD_HOME] ..."
    rsync -alogp --delete $MADMASK_HOME/ $BUILD_HOME/
    su - happyface3 -c ". /etc/profile; setup_android_sdk; $BUILD_HOME/madmask -b android &> /tmp/madmask.android-build.log &"
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

