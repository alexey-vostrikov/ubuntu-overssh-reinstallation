#!/bin/bash

DEFAUTL_PUBLICKEY=''
if [ -e "~/.ssh/authorized_keys" ]; then
  DEFAUTL_PUBLICKEY=$(head -n 1 ~/.ssh/authorized_keys)
fi

PUBLICKEY=$(whiptail --title "$PROG_TITLE" --inputbox "Set public key for authorized_keys:" $SIZE_X $SIZE_Y "$DEFAUTL_PUBLICKEY" 3>&1 1>&2 2>&3)

if [ -z "${PUBLICKEY}" ]; then
  exit;
fi
