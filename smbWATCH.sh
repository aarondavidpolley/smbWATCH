#!/bin/bash

################################################################################
# Author:    Aaron Polley                                                      #
# Date:      16/10/2017                                                        #
# Version:   1.0                                                              #
# Purpose:   Scripting for monitoring and unmounting SMB drives                #
#            Should be triggered by LaunchAgent using WatchPaths               #
################################################################################

#---Variables To Edit---#
ServerName="NAS"       #Specify the server sharing/bonjour name
ServerIP="10.9.8.7"       #Specify the server IP
ServerDomain="server.mycompany.private"       #Specify the server DNS name/hostname

#---Logic Variables---#
script_version="1.0"
user_id=`id -u`
user_name=`id -un $user_id`
home_dir=`dscl . read /Users/"$user_name" NFSHomeDirectory | awk '{print $2}'`
log_file="$home_dir/Library/Logs/smbWATCH.log"
os_vers=`sw_vers -productVersion | awk -F "." '{print $2}'`
DateTime=`date "+%a %b %d %H:%M:%S"`

#---Redirect output to log---#
exec >> $log_file 2>&1


#---Script Start---#

if [[ $1 = "debug" ]]; then
echo "*************************************************************************"
echo "$DateTime - smbWATCH beginning v${script_version}"
echo "$DateTime     - User:              $user_name"
echo "$DateTime     - User ID:           $user_id"
echo "$DateTime     - Home Dir:          $home_dir"
echo "$DateTime     - OS Vers:           10.${os_vers}"
fi

#--Check If Server Accessible---#
if ping -q -c 1 -W 1 "$ServerIP" >/dev/null; then

  if [[ $1 = "debug" ]]; then
   echo "$DateTime - Server IP is up"
   echo "$DateTime - Looking for $ServerName SMB volumes..."
  fi

   smbSharesName=`mount | grep "smbfs" | grep "$ServerName" | awk '{print $1}'`

   smbSharesIP=`mount | grep "smbfs" | grep "$ServerIP" | awk '{print $1}'`

   smbSharesDomain=`mount | grep "smbfs" | grep "$ServerDomain" | awk '{print $1}'`


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
  if [[ $1 = "debug" ]]; then
   echo "$DateTime - Server IP is down, nothing to do"
  fi
fi

if [[ $1 = "debug" ]]; then
  echo "$DateTime - Pausing for 5 seconds..."
fi

sleep 5

if [[ $1 = "debug" ]]; then
echo "$DateTime - Complete..."
echo "*************************************************************************"
fi

exit 0
