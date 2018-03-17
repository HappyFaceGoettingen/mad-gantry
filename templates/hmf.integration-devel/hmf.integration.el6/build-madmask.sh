#!/bin/bash

## --------------------------------------
##  HappyFace-MadMask development env
## --------------------------------------

## Changing ownership of Docker volume dirs to the HappyFace user.
chown -R happyface3:happyface3 /var/lib/MadMaskData
chown -R root:root /root/.ssh 


## Building and Installing HappyFace-MadMask
pushd /devel/HappyFace-MadMask
./rebuild.sh -b madmask
./rebuild.sh -b madfoxd
./rebuild.sh -b rlibs
./rebuild.sh -t
popd


## Changing configurations in HappyFace MadModules


## Changing Site directory in MadMask
SITE_NAME=$(ls /sites | grep -v default | head -n 1)
echo "Site = [$SITE_NAME]"
[ ! -e /sites/default ] && ln -vs $SITE_NAME /sites/default

MADMASK_HOME=/var/lib/HappyFace3/MadMask
echo "Applying a site configuration to [$MADMASK_HOME] in this container ..."
[ ! -L  $MADMASK_HOME/sites ] && mv -v $MADMASK_HOME/sites $MADMASK_HOME/sites.org
ln -vs /sites $MADMASK_HOME/sites


## Starting MadFoxd & MadMaskd (Ionic Mobile Server)
echo "Starting MadMask and MadFox daemons"
service madmaskd start
service madfoxd start

##  Done!! 

