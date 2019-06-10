#!/bin/bash

set -e

BOARD_DIR="../buildroot/board/raspberrypi0w"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="../br-external/board/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# Use custom config.txt
cp -f "../br-external/board/config.txt" "${BINARIES_DIR}/rpi-firmware/config.txt"

rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
