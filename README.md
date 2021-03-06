# Puritan

## A corruption resistant, fast boot embedded linux for running Pure Data on the Raspberry Pi Zero W.

###### Features:
- Stripped down Kernel: Boots to Pure Data in about 6 seconds
- Instant off: Power can be removed without shutdown
- Corruption proof: Uses a read-only squashfs root filesystem
- Automatically connects to wifi networks & provides a wifi hotspot
- Pure Data patch stored on accessible FAT32 partition on SD card
- ssh login with X forwarding to edit patch
- Designed for use with the HifiBerry DAC (loads drivers on boot)

###### To do:
- Enable writing to the filesystem in controlled circumstances to install packages
- Reduce boot time to 3 seconds or less

Pull requests welcomed, especially ones that improve boot time!

###### How to compile:

Note: you are building an operating system from scratch! You will need about 10GB of hard drive space, a fast internet connection, and a decent desktop computer or server running linux (this guide is for Debian/Ubuntu - other distributions will work but you will need to figure out the dependencies yourself).

0. Install dependencies:

```
sudo apt install sed make binutils build-essential gcc g++ bash patch gzip bzip2 perl tar cpio python unzip rsync bc wget libncurses5-dev git
```

1. Clone the repository: 

```
git clone https://github.com/jeremiahrose/Puritan.git
```

2. Initialise submodules to download the Buildroot source:

```
cd Puritan
git submodule init
git submodule update
```

3. Load the configuration into Buildroot 

```
cd buildroot
make BR2_EXTERNAL=../br-external puritan_defconfig
```

The project is now ready for building and/or further customisation!

To build the system simply run:
```
make
```
It will take between 40 minutes and 3 hours depending on your system and internet connection.
After it is finished, the SD card image found in `output/images` can be flashed directly to your SD and booted up on the RPi0w!

Note that all `make` commands should be run from the `buildroot` directory, and all `git` commands should be run from the `Puritan` directory.

To make changes to the Buildroot configuration run
```
make menuconfig
```

Buildroot will remember any changes you have saved, however if you want your configuration
changes to be seen by git you will need to first run `make savedefconfig`.

Similarly, to make changes to the kernel configuration run:
```
make linux-menuconfig
```
If you are doing this for the first time it will need to download the kernel source first.
Warning: changes saved from the kernel configurator **will be lost** and not compiled unless you first run
```
make linux-update-defconfig
```
I recommend that you always run `make savedefconfig` and `make linux-update-defconfig` after
every time you use the Buildroot and Kernel configuration tools respectively.

###### Note on branches:
After changing branches, running git pull, or otherwise changing the contents of
br-external/configs, the buildroot configuration **must** be updated again with:
```
make BR2_EXTERNAL=../br-external puritan_defconfig
```
If you add this to your `.git/hooks/post-checkout` file, git will do it automatically for you.

###### How to use:

You can change the Pure Data patch that is run at boot by replacing the 'patch.pd' file on the FAT32 partition on the SD card, or at build time by replacing this file:
```
br-external/board/patch.pd
```
If you want to use a different file, simply adjust 
```
br-external/board/rootfs_overlay/etc/init.d/S26puredata
```
to point to the new file and run `make` to rebuild the system (it will run much quicker than the initial build).

The default username is `jez` and the password is `password`. You should change these before building by editing
```
br-external/board/users.config
```
root privileges can be accessed with `sudo` and password `password`. If your Pi is going to be exposed to the internet, I would recommend disabling password access and instead adding your laptop's public ssh key to 
```
br-external/board/rootfs_overlay/home/jez/.ssh/authorized_keys
```
which will enable secure password-less login.

Puritan will by default create a wifi hotspot with ssid `Puritan` and key `password`. If you want it to connect to your wifi network instead, edit
```
br-external/board/rootfs_overlay/etc/wpa_supplicant/wpa_supplicant.conf
```
and add your wifi details there.
