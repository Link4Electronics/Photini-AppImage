#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm go

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package


# If the application needs to be manually built that has to be done down here
git clone https://gitlab.com/cznic/libtcl9.0.git
cd libtcl9.0
make
mv -v 

make-aur-package photini-git
