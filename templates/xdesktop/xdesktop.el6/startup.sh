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

/usr/bin/xdm
service xinetd start
# Start the ssh service
/usr/sbin/sshd -D
