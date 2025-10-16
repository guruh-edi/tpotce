#!/bin/bash

ACTUAL_ROOT=/opt/honeypot/actual-root
MOUNT_PATH=/opt/honeypot/mnt

echo $(whoami)

mkdir -p $ACTUAL_ROOT $MOUNT_PATH
rsync -a /bin /lib /usr/bin /etc $ACTUAL_ROOT

./main
