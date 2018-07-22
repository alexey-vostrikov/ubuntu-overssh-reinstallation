#!/bin/bash

AUTHFILE="$HOME/.ssh/authorized_keys"
DEFAUTL_PUBLICKEY=''
if [ -e "$AUTHFILE" ]; then
  DEFAUTL_PUBLICKEY=$(head -n 1 $AUTHFILE)
fi

PUBLICKEY=$(whiptail --title "$PROG_TITLE" --inputbox "Set public key for authorized_keys:" $SIZE_X $SIZE_Y "$DEFAUTL_PUBLICKEY" 3>&1 1>&2 2>&3)

if [ -z "${PUBLICKEY}" ]; then
  exit;
fi
