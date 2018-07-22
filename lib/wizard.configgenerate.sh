#!/bin/bash

CONFIG_PATH=$PROJECTPATH/tmp/config

echo '#!/bin/bash' > $CONFIG_PATH
echo "INTERFACE_DEV='$INTERFACE_DEV'" >> $CONFIG_PATH
echo "INTERFACE_IP='$INTERFACE_IP'" >> $CONFIG_PATH
echo "INTERFACE_NAMESERVER='$INTERFACE_NAMESERVER'" >> $CONFIG_PATH
echo "INTERFACE_NETMASK='$INTERFACE_NETMASK'" >> $CONFIG_PATH
echo "INTERFACE_GATEWAY='$INTERFACE_GATEWAY'" >> $CONFIG_PATH
echo "COUNTRY='$COUNTRY'" >> $CONFIG_PATH
echo "HOSTNAME='$HOSTNAME'" >> $CONFIG_PATH
echo "INSTALLERPASSWORD='$INSTALLERPASSWORD'" >> $CONFIG_PATH
echo "ROOTPASSWORD='$ROOTPASSWORD'" >> $CONFIG_PATH
echo "SSHPORT='$SSHPORT'" >> $CONFIG_PATH
echo "PUBLICKEY='$PUBLICKEY'" >> $CONFIG_PATH
echo "MIRROR_HTTP_PROXY='$MIRROR_HTTP_PROXY'" >> $CONFIG_PATH
echo "PRESEED_URL='$PRESEED_URL'" >> $CONFIG_PATH
