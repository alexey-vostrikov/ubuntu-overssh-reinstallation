#!/bin/bash

# check for root user
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

apt-get install -qqq -y curl git genisoimage grub-imageboot net-tools whiptail binutils xterm dnsutils

SCRIPT=`realpath $0`
PROJECTPATH=`dirname $SCRIPT`
PUBLICIP=$(dig +short myip.opendns.com @resolver1.opendns.com)

source $PROJECTPATH/lib/common.sh
source $PROJECTPATH/lib/wizard.welcome.sh
source $PROJECTPATH/lib/wizard.downloadiso.sh
source $PROJECTPATH/lib/wizard.country.sh
source $PROJECTPATH/lib/wizard.netinterface.sh
source $PROJECTPATH/lib/wizard.hostname.sh
source $PROJECTPATH/lib/wizard.http-mirror.sh
source $PROJECTPATH/lib/wizard.publickey.sh
source $PROJECTPATH/lib/wizard.stuff.sh
source $PROJECTPATH/lib/wizard.preseedgenerate.sh
source $PROJECTPATH/lib/wizard.uploadpreseed.sh
source $PROJECTPATH/lib/wizard.configgenerate.sh

