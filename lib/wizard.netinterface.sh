#!/bin/bash

DEFAULT_INTERFACE=$(route | grep '^default' | grep -o '[^ ]*$')
ENOREGEX="eno[0-9]" 
ENTRIES_OPTION=""
IFACES=( $(ip addr list | awk -F': ' '/^[0-9]/ {print $2}') )

for i in "${IFACES[@]}"
do
  if [[ "$i" != "lo" ]]; then
    if [[ "$i" =~ $ENOREGEX ]]; then
      PRDNAME=$i
      ENTRIES_OPTION+=" $i "
      ENTRIES_OPTION+="$(printf "%q" $PRDNAME)"
      if [ "$i" == "$DEFAULT_INTERFACE" ]; then
        ENTRIES_OPTION+=" ON"
      else
        ENTRIES_OPTION+=" OFF"
      fi
    else
      PRDNAME=$(udevadm test /sys/class/net/$i 2>/dev/null | grep ID_NET_NAME_PATH | cut -d "=" -f 2)
      if [ -n "${PRDNAME}" ]; then
        ENTRIES_OPTION+=" $i "
        ENTRIES_OPTION+="$(printf "%q" $PRDNAME)"
        if [ "$i" == "$DEFAULT_INTERFACE" ]; then
          ENTRIES_OPTION+=" ON"
        else
          ENTRIES_OPTION+=" OFF"
        fi
      fi
    fi
  fi
done

INTERFACE_DEV=$(whiptail --title "$PROG_TITLE" --radiolist  "Select main interface for server:" $SIZE_X $SIZE_Y $SIZE_LS $ENTRIES_OPTION 3>&1 1>&2 2>&3)

INTERFACE_IP=$(ifconfig $INTERFACE_DEV | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')
INTERFACE_NETMASK=$(ifconfig $INTERFACE_DEV | awk '/netmask/{print $4}')
INTERFACE_GATEWAY=$(route -n | grep $INTERFACE_DEV | grep '^0.0.0.0' | awk '{print $2}')
