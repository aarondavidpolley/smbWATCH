#!/bin/bash

################################################################################
# Author: 	Aaron Polley                                                       #
# Date:		30/08/2017                                                         #
# Version:	0.04                                                               #
# Purpose:  Scripting for monitoring and unmounting SMB drives                 #
#           Should be triggered by LaunchAgent						           #
################################################################################

#---Variables and such---#
script_version="0.04"
user_id=`id -u`
user_name=`id -un $user_id`
home_dir=`dscl . read /Users/"$user_name" NFSHomeDirectory | awk '{print $2}'`
log_file="$home_dir/Library/Logs/smbWATCH.log"
os_vers=`sw_vers -productVersion | awk -F "." '{print $2}'`
ShareName="DPN"
ShareIP="192.168.17.50"
ShareDomain="server.dpn.com.au"

#---Redirect output to log---#
exec >> $log_file 2>&1

#osascript -e "tell Application \"System Events\" to display alert\
# \"Incorrect server connection detected, removing\""

echo "*************************************************************************"
echo `date "+%a %b %d %H:%M:%S"` " - smbWATCH beginning v${script_version}"
echo `date "+%a %b %d %H:%M:%S"` "     - User:              $user_name"
echo `date "+%a %b %d %H:%M:%S"` "     - User ID:           $user_id"
echo `date "+%a %b %d %H:%M:%S"` "     - Home Dir:          $home_dir"
echo `date "+%a %b %d %H:%M:%S"` "     - OS Vers:           10.${os_vers}"

echo `date "+%a %b %d %H:%M:%S"` " - Unmounting network volumes..."

smbSharesName=`mount | grep "smbfs" | grep "$ShareName" | awk '{print $1}'`

smbSharesIP=`mount | grep "smbfs" | grep "$ShareIP" | awk '{print $1}'`

smbSharesDomain=`mount | grep "smbfs" | grep "$ShareDomain" | awk '{print $1}'`


#echo "Unmounting the following SMB Shares"

for a in $smbSharesName ; do
            echo "Un-mounting $a"
            /sbin/umount -f "$a"
done

for b in $smbSharesIP ; do
            echo "Un-mounting $b"
            /sbin/umount -f "$b"
done

for c in $smbSharesDomain ; do
            echo "Un-mounting $c"
            /sbin/umount -f "$c"
done


echo `date "+%a %b %d %H:%M:%S"` " - Complete..."

echo "*************************************************************************"

exit 0