#!/bin/bash

sudo apt install -y git dnsrecon

mkdir ~/opt
mkdir ~/.vpn
cd ~/opt

# Installing trevorspray
git clone https://github.com/blacklanternsecurity/trevorspray
cd trevorspray
pip3 install -r requirements.txt

# Cloning slu and other stuff
cd ~/opt
git clone --recurse-submodules https://github.com/puzzlepeaches/wordlists

# Installing metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall
msfdb init

# Pulling down username collection tooling and other stuff
pip3 install mailspoof
pip3 install checkdmarc
apt install dnsutils -y

# Username enum stuff
cd ~/opt
git clone https://github.com/0xZDH/BridgeKeeper
mv BridgeKeeper bridgekeeper
cd bridgekeeper
pip3 install requirements.txt

cd ~/opt
git clone https://github.com/initstring/linkedin2username
cd linkedin2username
pip3 install -r requirements.txt

# Installs go
# wget -q -O - https://git.io/vQhTU | bash


# Hunter.io from tty
# github.com/picatz/hunter
go get -u -v github.com/picatz/hunter

# Golang crap
go get -u -v github.com/bigb0sss/goPassGen
go get -u -v github.com/busterb/msmailprobe
go get -u github.com/patrickhener/goshs


# Other other junk
cd ~/opt
git clone https://github.com/xFreed0m/SMTPTester
cd SMTPTester
pip3 install -r requirements.txt

# Go to page like this https://www.zoominfo.com/pic/epic-systems-corporation/41307249 to use
# Protected by cloudflare so use proxycannon
cd ~/opt
git clone https://github.com/waffl3ss/ZIPuller
pip3 install cloudbrute pyfiglet

