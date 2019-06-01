#!/bin/bash

set -e

BOARD_DIR="../buildroot/board/raspberrypi0w"
BOARD_NAME="$(basename ${BOARD_DIR})"
echo "${BOARD_NAME}"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# Use custom config.txt
cp -f "/home/jez/tpt6/br-external/board/config.txt" "${BINARIES_DIR}/rpi-firmware/config.txt"

rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
