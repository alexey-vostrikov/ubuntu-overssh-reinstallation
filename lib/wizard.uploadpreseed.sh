#!/bin/bash

PRESEED_URL=''
if [ -n "${PRESEED_SERVER}" ]; then
  echo "You set preseed server at $PRESEED_SERVER"

  PRESEED_ID=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 24)

  curl -F "preseed=$PRESEED_ID" -F "preseed=@$PRESEED_PATH" $PRESEED_SERVER

  UPLOADURL="$PRESEED_SERVER/index.php?preseed=$PRESEED_ID"
  MD5ONLINE=$(curl -sL $UPLOADURL | md5sum | cut -d ' ' -f 1)
  MD5LOCAL=$(md5sum $PRESEED_PATH | awk '{ print $1 }')
  PRESEED_URL="$PRESEED_SERVER/index.php?preseed=$PRESEED_ID"

  echo "Your pressed file uploaded with '$PRESEED_URL'"
  if [ "$MD5ONLINE" == "$MD5LOCAL" ]; then
    echo "Checksum success"
  else
    echo "Checksum faild"
  fi
else
  echo "Your preseed is ready:"
  echo " ==================================== "
  cat $PRESEED_PATH
  echo " ==================================== "
  echo "Copy to your desire preseed location then modify config file before create iso and update grub."
fi
