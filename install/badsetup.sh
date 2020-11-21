#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install -y ripgrep openvpn fzf screen htop tldr nmap vim wget curl ncdu python3 python3-pip jq

echo "Installing golang"
wget -q -O - https://git.io/vQhTU | bash

echo "Installing Docker"
sudo apt-get -qq remove docker docker-engine docker.io* lxc-docker*
sudo apt-get -qq install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo sh -c "echo 'deb [arch=amd64] https://download.docker.com/linux/debian stretch stable' >> /etc/apt/sources.list"
sudo apt-get -qq update
sudo apt-get install docker-ce docker-compose -y
sudo groupadd docker
sudo usermod -aG docker ed
sudo systemctl enable docker --now

sudo curl https://raw.githubusercontent.com/rupa/z/master/z.sh \
          -o /etc/profile.d/z.sh

mkdir -p .local/share/tldr
tldr --update

tee -a ~/.bashrc << END
# Backwards command history easier
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

##########################
## Bash History

# Save 5,000 lines of history in memory
HISTSIZE=10000
# Save 2,000,000 lines of history to disk (will have to grep ~/.bash_history for full listing)
HISTFILESIZE=2000000
# Append to history instead of overwrite
shopt -s histappend
# Ignore redundant or space commands
HISTCONTROL=ignoreboth
# Ignore more
HISTIGNORE='ls:ll:ls -alh:pwd:clear:history'
# Set time format
HISTTIMEFORMAT='%F %T '
# Multiple commands on one line show up as a single line
shopt -s cmdhist

# ensure synchronization between Bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"

# Make sure screen sessions go bash_history
if [[ $TERM == screen ]]; then
   declare SCREEN_NAME=$(echo $STY | sed -nr 's/[^.]*\.(.*)/\1/p')
   if [[ $SCREEN_NAME ]]; then
       HISTFILE="${HISTFILE}.${SCREEN_NAME}.${WINDOW}"
       declare -p HISTFILE
   fi
   unset SCREEN_NAME
fi

END
