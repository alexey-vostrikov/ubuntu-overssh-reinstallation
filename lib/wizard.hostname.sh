#!/bin/bash

DEFAULTHOSTNAME=$(printf "%s" "$PUBLICIP" | sed 's/[^0-9]/\-/g' | sed 's/[\-]+/\-/g')

HOSTNAME=$(whiptail --inputbox --title "$PROG_TITLE" "Hostname:" $SIZE_X $SIZE_Y $DEFAULTHOSTNAME 3>&1 1>&2 2>&3)
