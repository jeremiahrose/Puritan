#!/bin/bash

echo "Note: make sure this (and all other) commands are run from the 'buildroot' directory"
echo "Initialising git submodules"
cd ../
git submodule init
git submodule update
echo "Initialising buildroot config"
cd buildroot
make BR2_EXTERNAL=../br-external tpt6_defconfig
echo "Done, now run 'make' to build the system"
