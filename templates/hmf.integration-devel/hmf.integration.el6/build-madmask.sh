#!/bin/bash

## --------------------------------------
##  HappyFace-MadMask development env
## --------------------------------------

## Changing ownership of Docker volume dirs to the HappyFace user.
chown -R happyface3:happyface3 /devel /sites /var/lib/MadMaskData
chown -R root:root /root/.ssh 

## Building and Installing HappyFace-MadMask
pushd /devel/HappyFace-MadMask
./rebuild.sh -w /tmp/MadMask -b madmask
./rebuild.sh -w /tmp/MadMask -b madfoxd
./rebuild.sh -w /tmp/MadMask -b rlibs
./rebuild.sh -w /tmp/MadMask -t
popd

## Changing directories
MADMASK_HOME=/var/lib/HappyFace3/MadMask
[ ! -L  $MADMASK_HOME/sites ] && mv -v $MADMASK_HOME/sites $MADMASK_HOME/sites.org
ln -vs /sites $MADMASK_HOME/sites


## Starting MadFoxd & MadMaskd (Ionic Mobile Server)
service madmaskd start
service madfoxd start

##  Done!! 

