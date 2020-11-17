#!/bin/bash

# update apt-get
sudo apt-get -qq update

# remove previously installed Docker
sudo apt-get -qq remove docker docker-engine docker.io* lxc-docker*

# install dependencies 4 cert
sudo apt-get -qq install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y

# add Docker repo gpg key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# add docker repo
sudo sh -c "echo 'deb [arch=amd64] https://download.docker.com/linux/debian stretch stable' >> /etc/apt/sources.list"

sudo apt-get -qq update

# install Docker
sudo apt-get install docker-ce -y

# manage Docker as a non-root user
sudo groupadd docker
sudo usermod -aG docker $USER

# configure Docker to start on boot
sudo systemctl enable docker
