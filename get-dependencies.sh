#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    go     \
    nsight-compute \
    python

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package


# If the application needs to be manually built that has to be done down here
make-aur-package debtap
debtap -u
if [ "$ARCH" = "x86_64" ]; then
    wget http://ftp.us.debian.org/debian/pool/main/t/tcl9.0/libtcl9.0_9.0.3+dfsg-1_amd64.deb
    debtap libtcl9.0_9.0.3+dfsg-1_amd64.deb
else
    wget http://ftp.us.debian.org/debian/pool/main/t/tcl9.0/libtcl9.0_9.0.3+dfsg-1_arm64.deb
    debtap libtcl9.0_9.0.3+dfsg-1_arm64.deb
fi
pacman -U libtcl9.0-9.0.3-1-${ARCH}.pkg.tar.zst
make-aur-package photini-git
