#!/bin/bash

cp $PROJECTPATH/lib/preseed.template $PROJECTPATH/tmp/preseed.cfg

PRESEED_PATH=$PROJECTPATH/tmp/preseed.cfg

sed -i "s#INTERFACE_DEV#$INTERFACE_DEV#g" $PRESEED_PATH
sed -i "s#INTERFACE_IP#$INTERFACE_IP#g" $PRESEED_PATH
sed -i "s#INTERFACE_NAMESERVER#$INTERFACE_NAMESERVER#g" $PRESEED_PATH
sed -i "s#INTERFACE_NETMASK#$INTERFACE_NETMASK#g" $PRESEED_PATH
sed -i "s#INTERFACE_GATEWAY#$INTERFACE_GATEWAY#g" $PRESEED_PATH
sed -i "s#COUNTRY#$COUNTRY#g" $PRESEED_PATH
sed -i "s#HOSTNAME#$HOSTNAME#g" $PRESEED_PATH
sed -i "s#INSTALLERPASSWORD#$INSTALLERPASSWORD#g" $PRESEED_PATH
sed -i "s#INITUSERNAME#$INITUSERNAME#g" $PRESEED_PATH
sed -i "s#INITUSERPASSWORD#$INITUSERPASSWORD#g" $PRESEED_PATH
sed -i "s#SSHPORT#$SSHPORT#g" $PRESEED_PATH
sed -i "s#PUBLICKEY#$PUBLICKEY#g" $PRESEED_PATH

if [ -z "$MIRROR_HTTP_PROXY" ]; then
  sed -i '/MIRROR_HTTP_PROXY/d' $PRESEED_PATH
else
  sed -i "s#MIRROR_HTTP_PROXY#$MIRROR_HTTP_PROXY#g" $PRESEED_PATH
fi
