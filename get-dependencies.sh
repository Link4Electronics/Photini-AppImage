#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    go     \
    python

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package


# If the application needs to be manually built that has to be done down here
make-aur-package debtap
wget http://ftp.us.debian.org/debian/pool/main/t/tcl9.0/libtcl9.0_9.0.3+dfsg-1_arm64.deb
debtap libtcl9.0_9.0.x_amd64.deb
pacman -U libtcl9.0-9.0.x-1-x86_64.pkg.tar.zst
make-aur-package photini-git
