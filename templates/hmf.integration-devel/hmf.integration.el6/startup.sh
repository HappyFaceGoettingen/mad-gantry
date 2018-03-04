#!/bin/bash

USER=${USER:-admin}
PASSWORD=${PASSWORD:-admin}
LANG=${LANG:-en_US.UTF-8}
TIMEZONE=${TIMEZONE:-Etc/UTC}

echo "LANG=\"${LANG}\"" > /etc/sysconfig/i18n 
echo "ZONE=\"${TIMEZONE}\"" >  /etc/sysconfig/clock
echo "UTC=\"True\""         >> /etc/sysconfig/clock
cp -p "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime 

echo "root:${PASSWORD}" |chpasswd

if [ ! -d /home/${USER} ] ; then
  useradd -m -k /etc/skel -s /bin/bash  ${USER}
  echo "${USER}:${PASSWORD}" |chpasswd
fi


## --------------------------------------
##  HappyFace-MadMask development env
## --------------------------------------

## Changing ownership of Docker volume dirs to the HappyFace user.
chown -R happyface3:happyface3 /devel /sites /var/lib/MadMaskData
chown -R root:root /root/.ssh 

## Building and Installing HappyFace-MadMask
pushd /devel/HappyFace-MadMask
./rebuild.sh build madmask
./rebuild.sh build madfoxd
#./rebuild.sh build libs
./rebuild.sh test
popd

## Changing directories
MADMASK_HOME=/var/lib/HappyFace3/MadMask
[ ! -L  $MADMASK_HOME/sites ] && mv -v $MADMASK_HOME/sites $MADMASK_HOME/sites.org
ln -vs /sites $MADMASK_HOME/sites


## Starting MadFoxd & MadMaskd (Ionic Mobile Server)
service madmaskd start
service madfoxd start

##  Done!! 


## Starting X and ssh
/usr/bin/xdm
service xinetd start
# Start the ssh service
/usr/sbin/sshd -D
