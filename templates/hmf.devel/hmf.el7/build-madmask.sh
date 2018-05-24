#!/bin/bash

## --------------------------------------
##  HappyFace-MadMask development env
## --------------------------------------

## Wait due to the loads of the other Docker VMs
echo "$(date): Waiting ..."
sleep 60


## Building and Installing HappyFace, MobileModules and so on
pushd /devel/PackageBuilder
./build-rpms.sh -p
echo "MADMASK_DEVEL = \"$MADMASK_DEVEL\""
[ "$MADMASK_DEVEL" != "ON" ] && ./build-rpms.sh -b madmask
[ "$MADMASK_DEVEL" == "ON" ] && ./build-rpms.sh -b devel
./build-rpms.sh -b madmodules
./build-rpms.sh -b madfoxd
./build-rpms.sh -b rlibs
./build-rpms.sh -b hf
./build-rpms.sh -b hf_atlas
./build-rpms.sh -b android-sdk
./build-rpms.sh -t
popd

## Changing ownership of Docker volume dirs to the HappyFace user.
echo "Changing ownership of Docker volume dirs ..."
chown -R root:root /root/.ssh 
chown happyface3:happyface3 /var/lib/MadMaskData/*
chown -R happyface3:happyface3 /firefox/*


## Getting the site name
SITE_NAME=$(ls /sites | grep -v default | head -n 1)
echo "Site = [$SITE_NAME]"


## Changing Site directory in MadMask
[ ! -e /sites/default ] && ln -vs $SITE_NAME /sites/default
MADMASK_HOME=/var/lib/HappyFace3/MadMask


## ADC is special for ATLAS, so build android application
if [ "$SITE_NAME" == "ADC" ]; then
    ## Building the Android application packages
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
    su - happyface3 -c "test -e $BUILD_HOME/data/$SITE_NAME/platforms || mkdir -pv $BUILD_HOME/data/$SITE_NAME/platforms"
    su - happyface3 -c "ln -vs data/$SITE_NAME/platforms $BUILD_HOME/platforms"
    su - happyface3 -c ". /etc/profile; setup_android_sdk; $BUILD_HOME/madmask -b android &> /tmp/madmask.android-build.log &"
fi


## Changing configurations in HappyFace MadModules



## Starting MadFoxd & MadMaskd (Ionic Mobile Server)
echo "Starting MadMask, MadFox, SSH, HappyFace daemons"
systemctl enable madmaskd.service
systemctl enable madfoxd.service
systemctl enable crond.service
systemctl enable sshd.service
systemctl enable httpd.service


##  Done!! 
exec /usr/sbin/init

