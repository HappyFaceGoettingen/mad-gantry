#!/bin/bash

## --------------------------------------
##  HappyFace-MadMask Admin Server
## --------------------------------------

## Wait due to the loads of the other Docker VMs
echo "$(date): Waiting ..."
sleep 60


## Building and Installing Admin server
pushd /devel/PackageBuilder
./build-rpms.sh -p
./build-rpms.sh -b admin-server
./build-rpms.sh -t admin
popd

## Changing ownership of Docker volume dirs to root and HappyFace user.
echo "Changing ownership of Docker volume dirs ..."
chown -R root:root /root/.ssh 


## Starting SSH adn admin server
echo "Starting SSH, Admin gateway Socket, Admin gateway Daemon"
/usr/share/admin-server/start-web2ssh.sh &
systemctl enable sshd.service
systemctl enable httpd.service


##  Done!! 
exec /usr/sbin/init

