#!/bin/bash
PUBLIC_IP=203.217.93.35
set -e
echo "Running make..."
cd /home/jez/tpt6/buildroot && make
echo "Copying image to $PUBLIC_IP..."
scp -oStrictHostKeyChecking=no /home/jez/tpt6/buildroot/output/images/sdcard.img jez@$PUBLIC_IP:/tmp/sdcard.img
echo "Flashing image to /dev/mmvblk0 on RPi..."
ssh -oStrictHostKeyChecking=no jez@$PUBLIC_IP 'echo password | sudo -S sh -c "dd if=/tmp/sdcard.img of=/dev/mmcblk0 && reboot"'
echo "Resetting known hosts..."
ssh-keygen -f "/home/jez/.ssh/known_hosts" -R "$PUBLIC_IP"
echo "Done!"
