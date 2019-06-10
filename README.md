#RPi0W

##A power-loss resistant, fast boot embedded linux for running PD on RPi0W.

######Features:
- Instant off: Power can be removed without proper shutdown
- Corruption proof: Uses a read-only squashfs root filesystem
- Stripped down Kernel: Boots in about 4 seconds
- Automatically provides a wifi hotspot with ssh login
- Designed for use with the HifiBerry DAC (loads drivers on boot)

######Not yet implemented:
- Run Pure Data on boot
- Enable writing to the filesystem in controlled circumstances to install packages

######How to use:

1. Clone the repository: 

```
git clone https://github.com/jeremiahrose/RPi0w-PD.git
```

2. Initialise submodules to download the Buildroot source:

```
cd RPiow-PD
git submodule init
git submodule update
```

3. Load the configuration into Buildroot 

```
cd buildroot
make BR2_EXTERNAL=../br-external tpt6_defconfig
```

The project is now ready for building and/or further customisation!

To build the system simply run:
```
make
```
It will take between 40 minutes and 3 hours depending on your system and internet connection.
Note that all `make` commands should be run from the `buildroot` directory, and all `git` should be run from the `RPi0w-PD` directory.

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

######Note on branches:
After changing branches, running git pull, or otherwise changing the contents of
br-external/configs, the buildroot configuration **must** be updated again with:
```
make BR2_EXTERNAL=../br-external tpt6_defconfig
```
