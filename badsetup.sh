#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install -qq -y ripgrep openvpn fzf screen htop tldr nmap vim wget curl ncdu python3 python3-pip jq

echo "Installing golang"
wget -q -O - https://git.io/vQhTU | bash

echo "Installing Docker"
sudo apt-get -qq remove docker docker-engine docker.io* lxc-docker*
sudo apt-get -qq install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo sh -c "echo 'deb [arch=amd64] https://download.docker.com/linux/debian stretch stable' >> /etc/apt/sources.list"
sudo apt-get -qq update
sudo apt-get install docker-ce -y
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker --now

sudo curl https://raw.githubusercontent.com/rupa/z/master/z.sh \
          -o /etc/profile.d/z.sh

tldr --update

