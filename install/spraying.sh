#!/bin/bash

sudo apt install -y git

mkdir ~/opt
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

wget -q -O - https://git.io/vQhTU | bash


# Hunter.io from tty
# github.com/picatz/hunter
go get -u -v github.com/picatz/hunter

cd ~/opt
git clone https://github.com/bigb0sss/goPassGen.git
cd goPassGen
go build goPassGen.go
sudo mv goPassGen /usr/bin/gopassgen

