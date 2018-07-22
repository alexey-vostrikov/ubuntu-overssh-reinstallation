#!/bin/bash

DEFAULT_MIRROR_HTTP_PROXY=$(apt-config dump | grep "Acquire::HTTP::Proxy" | cut -d '"' -f2)

MIRROR_HTTP_PROXY=$(whiptail --title "$PROG_TITLE" --inputbox "Set mirror http proxy for apt:" $SIZE_X $SIZE_Y "$DEFAULT_MIRROR_HTTP_PROXY" 3>&1 1>&2 2>&3)

if [ -n "${MIRROR_HTTP_PROXY}" ]; then
  if [[ ! $MIRROR_HTTP_PROXY =~ $URL_REGEX ]]; then
    echo "Mirror http proxy url not valid";
    exit;
  fi
fi
