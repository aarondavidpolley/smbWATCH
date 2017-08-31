#!/bin/bash

################################################################################
# Author:    Aaron Polley                                                      #
# Date:      31/08/2017                                                        #
# Version:   0.10                                                              #
# Purpose:   Scripting for monitoring and unmounting SMB drives                #
#            Should be triggered by LaunchAgent using WatchPaths               #
################################################################################

#---Variables and such---#
script_version="0.10"
user_id=`id -u`
user_name=`id -un $user_id`
home_dir=`dscl . read /Users/"$user_name" NFSHomeDirectory | awk '{print $2}'`
log_file="$home_dir/Library/Logs/smbWATCH.log"
os_vers=`sw_vers -productVersion | awk -F "." '{print $2}'`
DateTime=`date "+%a %b %d %H:%M:%S"`
ShareName="DPN"
ShareIP="192.168.17.50"
ShareDomain="server.dpn.com.au"

#---Redirect output to log---#
exec >> $log_file 2>&1


#---User Alert---#
#osascript -e "tell Application \"System Events\" to display alert\
# \"Incorrect server connection detected, removing\""

#---Script Start---#
echo "*************************************************************************"
echo "$DateTime - smbWATCH beginning v${script_version}"
echo "$DateTime     - User:              $user_name"
echo "$DateTime     - User ID:           $user_id"
echo "$DateTime     - Home Dir:          $home_dir"
echo "$DateTime     - OS Vers:           10.${os_vers}"

#--Check If Server Accessible---#
if ping -q -c 1 -W 1 "$ShareIP" >/dev/null; then

   echo "$DateTime - Server IP is up"

   echo "$DateTime - Looking for $ShareName SMB volumes..."

   smbSharesName=`mount | grep "smbfs" | grep "$ShareName" | awk '{print $1}'`

   smbSharesIP=`mount | grep "smbfs" | grep "$ShareIP" | awk '{print $1}'`

   smbSharesDomain=`mount | grep "smbfs" | grep "$ShareDomain" | awk '{print $1}'`


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

else
   echo "$DateTime - Server IP is down, nothing to do"
fi


echo "$DateTime - Complete..."

echo "*************************************************************************"

exit 0