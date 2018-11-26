#!/bin/bash

# check for root user
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

SCRIPT=`realpath $0`
PROJECTPATH=`dirname $SCRIPT`
CONFIGFILE=$PROJECTPATH/tmp/config
ISO_DEST=$PROJECTPATH/tmp/ubuntu-overssh-reinstall.iso
if [ ! -f $CONFIGFILE ]; then
  echo "Please create config file config on '$CONFIGFILE'"
  exit 1
fi

if [ ! -f $ISO_DEST ]; then
  echo "Please create iso file first."
  exit 1
fi

source $PROJECTPATH/lib/common.sh
source $CONFIGFILE

if [ ! -f /etc/default/grub ]; then
  echo "Seems be grub dosnt install or not matched version"
  exit 1
fi

rm /boot/images -rf
mkdir -p /boot/images/
cp $ISO_DEST /boot/images/iso.iso

update-grub

BOOTABLEGRUBNAME=`cat /boot/grub/grub.cfg | grep iso | head -n 1 | cut -d \" -f2`

if [ -z "$BOOTABLEGRUBNAME" ]; then
  echo "Seems be grub imageboot not work as expected. try manual"
  exit 1
fi

BACKUPSUFFIX=`date +"%Y%m%d_%H%M%S"`
GRUBBACKUPFILE="$PROJECTPATH/grub.backup_$BACKUPSUFFIX"
if [ ! -f $GRUBBACKUPFILE ]; then
  cp /etc/default/grub $GRUBBACKUPFILE
fi

sed -i "s/GRUB_DEFAULT=0/GRUB_DEFAULT='$BOOTABLEGRUBNAME'/g" /etc/default/grub

update-grub

echo "1. Check 'preseed.cfg' file for $PRESEED_URL"
echo " ==================================== "
cat $PROJECTPATH/tmp/preseed.cfg
echo " ==================================== "
echo "2. Reboot current machine and wait to init to ssh installer"
echo "3. Connect using ssh client ssh installer@$INTERFACE_IP"
echo "4. Your password is $INSTALLERPASSWORD"
