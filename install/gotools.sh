#!/bin/bash

echo "Updating naabu"
GO111MODULE=on go get -u  github.com/projectdiscovery/naabu/v2/cmd/naabu

echo "Updating anew"
GO111MODULE=on go get -u github.com/tomnomnom/anew 

echo "Updating nuclei"
GO111MODULE=on go get -u  github.com/projectdiscovery/nuclei/v2/cmd/nuclei

echo "Updating subfinder"
GO111MODULE=on go get -u  github.com/projectdiscovery/subfinder/v2/cmd/subfinder

echo "Updating dnsprobe"
GO111MODULE=on go get -u  github.com/projectdiscovery/dnsprobe

echo "Updating shuffledns"
GO111MODULE=on go get -u  github.com/projectdiscovery/shuffledns/cmd/shuffledns

echo "Updating httpx"
GO111MODULE=auto go get -u  github.com/projectdiscovery/httpx/cmd/httpx

echo "Updating mapcidr"
GO111MODULE=auto go get -u  github.com/projectdiscovery/mapcidr/cmd/mapcidr

echo "Updating ffuf"
go get -u  github.com/ffuf/ffuf

echo "Updating amass"
go get  -u github.com/OWASP/Amass

echo "Updating gospider"
go get -u github.com/jaeles-project/gospider

echo "Updating gau"
GO111MODULE=on go get -u github.com/lc/gau

echo "Updating wurl"
go get -u github.com/bp0lr/wurl
