#/bin/bash

set -x

make linux-menuconfig
cp output/build/linux-rpi-4.18.y/.config ../br-external/configs/kernel_config
