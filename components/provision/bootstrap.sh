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

echo -e "$LOG_INFO ${Y}Install git${D}"
sudo apt-get install -y git

echo -e "$LOG_INFO ${Y}Install docker${D}"
echo -e "$LOG_INFO Uninstall old docker versions"
sudo apt-get remove -y docker docker-engine docker.io containerd runc
echo -e "$LOG_INFO Install docker using the convenience script"
curl -fsSL https://get.docker.com | sudo bash -
