#!/bin/bash

## --------------------------------------
##  HappyFace-MadMask development env
## --------------------------------------

## Wait due to the loads of the other Docker VMs
sleep 60


## Building HappyFace Core
cd /var/lib && git clone https://github.com/HappyFaceGoettingen/HappyFace-Integration-Server -b MadUpdate
cd /var/lib/HappyFace-Integration-Server && git pull origin && ./rebuild.sh happyface
cd /var/lib/HappyFace-Integration-Server && git pull origin && ./rebuild.sh atlas
yum clean all
yum --nogpgcheck -y install /var/lib/HappyFace-Integration-Server/RPMS/x86_64/HappyFaceCore-*.rpm
yum --nogpgcheck -y install /var/lib/HappyFace-Integration-Server/RPMS/x86_64/HappyFace-ATLAS-*.rpm


## Changing ownership of Docker volume dirs to the HappyFace user.
chown happyface3:happyface3 /var/lib/MadMaskData/*
chown -R root:root /root/.ssh 


## Building and Installing HappyFace-MadMask
pushd /devel/HappyFace-MadMask
./rebuild.sh -p
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
    #PLATFORMS=$MADMASK_HOME/data/$SITE_NAME/platforms
    #su - happyface3 -c "! test -e $PLATFORMS && mkdir -pv $PLATFORMS; ln -s $PLATFORMS $MADMASK_HOME/platforms"
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

