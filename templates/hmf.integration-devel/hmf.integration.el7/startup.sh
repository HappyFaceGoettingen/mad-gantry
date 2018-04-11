#!/bin/bash

## Calling the madmask builder (this exists in the same path)
/bin/bash $(dirname $0)/build-madmask.sh

#/usr/bin/xdm
service xinetd start
# Start the ssh service
/usr/sbin/sshd -D
