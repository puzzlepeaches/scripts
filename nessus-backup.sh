#!/bin/bash

# Uncomment the commented echo commands if you need to debug the script
# Tested with latest version 8.12.1 as of 20201125

# Set your nessus creds below 
USER=""
PASS=""

HOSTS=$1

while IFS= read -r ip
do
  
  echo "Getting token for $ip"
  TOKEN=`curl -sk -X POST -d "username=$USER&password=$PASS" https://"$ip":8834/session | jq -r '.token'`
  # echo -e "TOKEN is $TOKEN\n"
  
  # echo "Getting folder ID for $ip"
  FOLDER_ID=`curl -sk -X GET -H "X-Cookie: token=$TOKEN" https://"$ip":8834/folders | jq ".folders[1].id"`
  # echo -e "FOLDER_ID is $FOLDER_ID\n"
  
  # echo "Getting scan ID for $ip"
  SCAN_ID=`curl -sk -X GET -H "X-Cookie: token=$TOKEN" https://"$ip":8834/scans | jq ".scans[].id"`
  # echo -e "SCAN_ID is $SCAN_ID\n"

  # echo "Requesting an export of scans on $ip"
  EXPORT_REQ=`curl -sk -X POST -H "X-Cookie: token=$TOKEN" -d "format=nessus" https://"$ip":8834/scans/"$SCAN_ID"/export | jq `

  FILE_TOKEN=`echo $EXPORT_REQ | jq -r '.token'`
  FILE_ID=`echo $EXPORT_REQ | jq -r '.file'`
  # echo "FILE_TOKEN is $FILE_TOKEN"
  # echo -e "FILE_ID is $FILE_ID\n"

  # You can theoretically check the status of the download export and not attempt a download until it equals "true"
  echo "Sleeping..."
  sleep 45
  
  # Setting a timestamp value for the file output
  # This way, we can run this on a cron and not overwrite anything
  STAMP=`date +%Y%m%d%H%M%S`

  echo "Downloading..."
  curl -sk -X GET -H "X-Cookie: token=$TOKEN" https://"$ip":8834/scans/"$SCAN_ID"/export/"$FILE_ID"/download -o $ip.$STAMP.nessus
  
  # Feel free to comment this out if you don't want it
  # Essentially creates a log file saying when the export attempt was made and if it was successful
  # Currently prints to file and stdout
  if grep -q NessusClientData "$ip.$STAMP.nessus"; then
	  DATE=`date +"%c"`
	  echo -e "$DATE\t "$ip"\t SUCCESS" | tee -a nessus-backup.log
  else
	  echo -e "$DATE\t "$ip"\t FAILED" | tee -a nessus-backup.log
  fi

done < "$HOSTS"


