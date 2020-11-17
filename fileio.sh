#!/bin/bash

i=1

urfile=$1
END=$2

while ((i<=END)); do
    curl -sk -F "file=@$urfile" https://file.io | jq .link | tee -a links.txt
    let i++
done
