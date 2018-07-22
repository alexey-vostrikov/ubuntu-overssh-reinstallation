#!/bin/bash

UBUNTU_VERSION=$(whiptail --title "$PROG_TITLE"  --radiolist \
 "Select version of ubuntu want to install" $SIZE_X $SIZE_Y 3 \
 "UBUNTUISO_BIONIC" "Ubuntu 18.04 bionic (LTS)" ON \
 "UBUNTUISO_XENIAL" "Ubuntu 16.04 xenial (LTS)" OFF \
 "SKIP" "Skip download iso" OFF \
3>&1 1>&2 2>&3)

if [ "$UBUNTU_VERSION" == "UBUNTUISO_BIONIC" ]; then
  curl -o $PROJECTPATH/tmp/mini.iso -sL -O -C - $UBUNTUISO_BIONIC
elif [ "$UBUNTU_VERSION" == "UBUNTUISO_XENIAL" ]; then
  curl -o $PROJECTPATH/tmp/mini.iso -sL -O -C - $UBUNTUISO_XENIAL
elif [ "$UBUNTU_VERSION" != "SKIP" ]; then
  exit;
fi
