#!/bin/bash


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


readonly LOG_INFO="[\e[34mINFO\e[0m]"
readonly Y="\e[93m"
readonly D="\e[0m"


echo -e "$LOG_INFO ${Y}Update apt cache${D}"
sudo apt-get -y update

echo -e "$LOG_INFO ${Y}Install basics${D}"
sudo apt-get install -y ca-certificates
sudo apt-get install -y curl
sudo apt-get install -y gnupg
sudo apt-get install -y lsb-release

echo -e "$LOG_INFO ${Y}Install tools${D}"
sudo apt-get install -y git
sudo apt-get install -y tilix

echo -e "$LOG_INFO ${Y}Install docker${D}"
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

sudo apt-get install-y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker "$USER"
newgrp docker

docker run -rm hello-world:latest
