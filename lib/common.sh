#!/bin/bash

eval `resize`

UBUNTUISO_BIONIC='http://archive.ubuntu.com/ubuntu/dists/bionic/main/installer-amd64/current/images/netboot/mini.iso'
UBUNTUISO_XENIAL='http://archive.ubuntu.com/ubuntu/dists/xenial/main/installer-amd64/current/images/netboot/mini.iso'
PROG_TITLE="AASAAM Ubuntu overssh installation"
URL_REGEX='(http)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
SIZE_X=$(( $LINES - 12 ))
SIZE_Y=$(( $COLUMNS - 8 ))
SIZE_LS=$(( $LINES - 24 ))


function to_int {
  local -i num="10#${1}"
  echo "${num}"
}

function port_is_ok {
  local port="$1"
  local -i port_num=$(to_int "${port}" 2>/dev/null)

  if (( $port_num < 1 || $port_num > 65535 )) ; then
    echo 'faild'
    return
  fi

  echo 'ok'
}

function validate_ip() {
  local ip=$1
  local stat=1
  if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    OIFS=$IFS
    IFS='.'
    ip=($ip)
    IFS=$OIFS
    [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
    && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
    stat=$?
  fi

  return $stat
}
