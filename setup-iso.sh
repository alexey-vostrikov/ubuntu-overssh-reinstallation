#!/bin/bash

# check for root user
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

SCRIPT=`realpath $0`
PROJECTPATH=`dirname $SCRIPT`
CONFIGFILE=$PROJECTPATH/tmp/config
if [ ! -f $CONFIGFILE ]; then
  echo "Please create config file config on '$CONFIGFILE'"
  exit 1
fi

source $PROJECTPATH/lib/common.sh
source $CONFIGFILE

ISO_FILE=$PROJECTPATH/tmp/mini.iso
if [ ! -f $ISO_FILE ]; then
  echo "File mini.iso not found. Download it $UBUNTUISO_BIONIC"
  exit 1
fi

# iso
ISO_DIR=$PROJECTPATH/tmp/ubuntu-overssh-iso
ISO_DEST=$PROJECTPATH/tmp/ubuntu-overssh-reinstall.iso
umount /mnt/ubuntu-overssh-iso 2> /dev/null
mkdir -p /mnt/ubuntu-overssh-iso
mount -o loop $ISO_FILE /mnt/ubuntu-overssh-iso 2> /dev/null
rm -rf $ISO_DIR
mkdir $ISO_DIR
cp -rT /mnt/ubuntu-overssh-iso $ISO_DIR

# copy preseed
cp $PROJECTPATH/tmp/preseed.cfg $ISO_DIR/preseed.cfg

# replace vairables
sed -i 's/timeout 0/timeout 300/g' $ISO_DIR/prompt.cfg
sed -i 's/timeout 0/timeout 300/g' $ISO_DIR/isolinux.cfg

# update kernel options
sed -i "s#append #append priority=critical auto=true preseed/url='$PRESEED_URL' netcfg/hostname=$HOSTNAME interface=$INTERFACE_DEV netcfg/disable_dhcp=true netcfg/get_ipaddress=$INTERFACE_IP netcfg/get_netmask=$INTERFACE_NETMASK netcfg/get_gateway=$INTERFACE_GATEWAY netcfg/get_nameservers=$INTERFACE_NAMESERVER #g" $ISO_DIR/txt.cfg

# create iso
mkisofs -D -r -V UBUNTU_SERVER -cache-inodes -J -l -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o $ISO_DEST $ISO_DIR

echo "Your network iso is ready '$ISO_DEST'"
