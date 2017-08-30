#!/bin/bash

#osascript -e "tell Application \"System Events\" to display alert\
# \"Incorrect server connection detected, removing\""

ShareName="DPN"

smbSharesName=`mount | grep "smbfs" | grep "$ShareName" | awk '{print $1}'`

ShareIP="192.168.17.50"

smbSharesIP=`mount | grep "smbfs" | grep "$ShareIP" | awk '{print $1}'`

ShareDomain="server.dpn.com.au"

smbSharesDomain=`mount | grep "smbfs" | grep "$ShareDomain" | awk '{print $1}'`


#echo "Unmounting the following SMB Shares"

for a in $smbSharesName ; do
            echo "$a"
            /sbin/umount -f "$a"
done

for b in $smbSharesIP ; do
            echo "$b"
            /sbin/umount -f "$b"
done

for c in $smbSharesDomain ; do
            echo "$c"
            /sbin/umount -f "$c"
done


exit 0