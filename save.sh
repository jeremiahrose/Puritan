echo "saving Buildroot defconfig"
make savedefconfig
echo "saving Kernel defconfig"
make linux-update-defconfig
