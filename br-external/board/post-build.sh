#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

# Generate ssh keys
rm ${TARGET_DIR}/etc/ssh/ssh_host_*
ssh-keygen -f ${TARGET_DIR}/etc/ssh/ssh_host_rsa_key -N '' -t rsa
ssh-keygen -f ${TARGET_DIR}/etc/ssh/ssh_host_dsa_key -N '' -t dsa
ssh-keygen -f ${TARGET_DIR}/etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
ssh-keygen -f ${TARGET_DIR}/etc/ssh/ssh_host_ed25519_key -N '' -t ed25519

