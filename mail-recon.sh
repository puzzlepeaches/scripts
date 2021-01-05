#!/bin/bash

# A really crap script to get info on target domain mail servers
# Usage: ./mail-recon.sh acme.com

# You might need to...
# pip3 install mailspoof
# pip3 install checkdmarc
# apt install dnsutils -y

domain="$1"

mailspoof -d $domain -o mailspoof."$domain".json
checkdmarc $domain -o checkdmarc."$domain".json
dig +short $domain MX | tee digmx."$domain".txt
dig +short $domain TXT | tee digtxt."$domain".txt

for i in owa post mail mymail exchange autodiscover exch exch01 outlook
do
        host $i.$domain | tee -a exchange-enum."$domain".txt
done

curl -sk "https://login.microsoftonline.com/getuserrealm.srf?login=test@"$domain"" | jq | tee o365usageenum.json
