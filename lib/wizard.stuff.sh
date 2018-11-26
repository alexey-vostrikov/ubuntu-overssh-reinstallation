#!/bin/bash

if [ ! -f $PROJECTPATH/tmp/INSTALLERPASSWORD.txt ]; then
  head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 > $PROJECTPATH/tmp/INSTALLERPASSWORD.txt
fi

if [ ! -f $PROJECTPATH/tmp/ROOTPASSWORD.txt ]; then
  head /dev/urandom | tr -dc A-Za-z0-9 | head -c 24 > $PROJECTPATH/tmp/ROOTPASSWORD.txt
fi

DEFAULT_INSTALLERPASSWORD=$(cat $PROJECTPATH/tmp/INSTALLERPASSWORD.txt)
DEFAULT_ROOTPASSWORD=$(cat $PROJECTPATH/tmp/ROOTPASSWORD.txt)
DEFAULT_SSHPORT=`shuf -i 49152-65535 -n 1`

INSTALLERPASSWORD=$(whiptail --title "$PROG_TITLE" --inputbox "Set installer user password for installation:" $SIZE_X $SIZE_Y "$DEFAULT_INSTALLERPASSWORD" 3>&1 1>&2 2>&3)
if [ -z "${INSTALLERPASSWORD}" ]; then
  exit;
fi

ROOTPASSWORD=$(whiptail --title "$PROG_TITLE" --inputbox "Set root password for after installation:" $SIZE_X $SIZE_Y "$DEFAULT_ROOTPASSWORD" 3>&1 1>&2 2>&3)
if [ -z "${ROOTPASSWORD}" ]; then
  exit;
fi

SSHPORT=$(whiptail --title "$PROG_TITLE" --inputbox "Set ssh port for after installation:" $SIZE_X $SIZE_Y "$DEFAULT_SSHPORT" 3>&1 1>&2 2>&3)

PORTRESULT=$(port_is_ok $SSHPORT);
if [ "$PORTRESULT" != 'ok' ]; then
  exit;
fi
