#!/bin/bash

whiptail --title "$PROG_TITLE" --yesno "Do you really need to reinstall ubuntu over ssh?" $SIZE_X $SIZE_Y
CHOICEs=$?

if [ "$CHOICEs" -eq "1" ]; then
  exit;
fi
