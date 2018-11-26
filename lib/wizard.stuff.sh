#!/bin/bash

if [ ! -f $PROJECTPATH/tmp/INSTALLERPASSWORD.txt ]; then
  head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12 > $PROJECTPATH/tmp/INSTALLERPASSWORD.txt
fi

if [ ! -f $PROJECTPATH/tmp/INITUSERPASSWORD.txt ]; then
  head /dev/urandom | tr -dc A-Za-z0-9 | head -c 24 > $PROJECTPATH/tmp/INITUSERPASSWORD.txt
fi

if [ ! -f $PROJECTPATH/tmp/RANDOM_INITUSERPOSTFIX.txt ]; then
  head /dev/urandom | tr -dc a-z0-9 | head -c 5 > $PROJECTPATH/tmp/RANDOM_INITUSERPOSTFIX.txt
fi

DEFAULT_INSTALLERPASSWORD=$(cat $PROJECTPATH/tmp/INSTALLERPASSWORD.txt)

RANDOM_INITUSERPOSTFIX=$(cat $PROJECTPATH/tmp/RANDOM_INITUSERPOSTFIX.txt)
DEFAULT_INITUSERNAME="z$RANDOM_INITUSERPOSTFIX"
DEFAULT_INITUSERPASSWORD=$(cat $PROJECTPATH/tmp/INITUSERPASSWORD.txt)

DEFAULT_SSHPORT=`shuf -i 50000-64000 -n 1`

INSTALLERPASSWORD=$(whiptail --title "$PROG_TITLE" --inputbox "Set installer user password for installation:" $SIZE_X $SIZE_Y "$DEFAULT_INSTALLERPASSWORD" 3>&1 1>&2 2>&3)
if [ -z "${INSTALLERPASSWORD}" ]; then
  exit;
fi

INITUSERNAME=$(whiptail --title "$PROG_TITLE" --inputbox "Set default username:" $SIZE_X $SIZE_Y "$DEFAULT_INITUSERNAME" 3>&1 1>&2 2>&3)
if [ -z "${INITUSERNAME}" ]; then
  exit;
fi

INITUSERPASSWORD=$(whiptail --title "$PROG_TITLE" --inputbox "Set password for '$INITUSERNAME':" $SIZE_X $SIZE_Y "$DEFAULT_INITUSERPASSWORD" 3>&1 1>&2 2>&3)
if [ -z "${INITUSERPASSWORD}" ]; then
  exit;
fi

SSHPORT=$(whiptail --title "$PROG_TITLE" --inputbox "Set ssh port for after installation:" $SIZE_X $SIZE_Y "$DEFAULT_SSHPORT" 3>&1 1>&2 2>&3)

PORTRESULT=$(port_is_ok $SSHPORT);
if [ "$PORTRESULT" != 'ok' ]; then
  exit;
fi
