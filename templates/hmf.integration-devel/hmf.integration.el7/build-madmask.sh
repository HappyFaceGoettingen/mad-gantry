#!/bin/bash

## --------------------------------------
##  HappyFace-MadMask development env
## --------------------------------------
dbus-uuidgen > /var/lib/dbus/machine-id
/sbin/init

## Changing ownership of Docker volume dirs to the HappyFace user.
service sshd start; service sshd stop

##  Done!! 

