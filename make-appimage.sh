#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q photini-git | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/jim-easterbrook/Photini/refs/heads/main/src/doc/images/photini_logo.png
export DESKTOP=DUMMY
export MAIN_BIN=photini

# Deploy dependencies
quick-sharun /usr/nin/photini

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
