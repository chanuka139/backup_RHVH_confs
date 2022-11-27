#!/bin/bash

#This script will get the backups of the hosts configuration files.

if [ $# -eq 0 ]
  then
	SC_NAME=$(basename "$0")
	echo "Usage: sh $SC_NAME <RHVH Hostname/Host IP>"
	exit 1;
fi

HOST=$1
BASE_BACKUP_DIR=/root/backup/


echo "Starting to check the host reachablity."

ping -c1 -W1 -q $HOST &>/dev/null
status=$( echo $? )
if [[ $status == 0 ]] ; then
 	echo "Connection to the host is success."
else
 	echo "Connection to the host seems to have an issue. Check the hostname/IP and try again."
 	exit 0;
fi


if [ ! -d $BASE_BACKUP_DIR ]
  then
	echo "$BASE_BACKUP_DIR does not exist. Creating now."
	mkdir -p $BASE_BACKUP_DIR
  else
	echo "$BASE_BACKUP_DIR already exists."
fi


cd $BASE_BACKUP_DIR

echo "Creating host backup directory."
mkdir -p $BASE_BACKUP_DIR/$HOST

echo "Taking the host configuration backups."
scp -rp root@$HOST:/etc/ $BASE_BACKUP_DIR/$HOST/

echo "$HOST Configuration backup completed."

exit 0;

