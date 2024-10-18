#!/bin/bash
# @file bootstrap.sh
# @brief Bootstrap script to provision the Vagrantbox and to install into non-virtual Ubuntu systems.
# @description
#   This script is used to provision the Vagrantbox and to install into non-virtual Ubuntu systems.
#   It installs some basic packages and tools, docker, minikube and helm.

# shellcheck disable=SC1091

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


echo "[INFO] Info"
echo "User     = $USER"
echo "Hostname = $HOSTNAME"
echo "Home dir = $HOME"


echo "[INFO] Install packages and tools"

sudo apt-get update
sudo apt-get install -y ca-certificates \
  curl \
  gnupg \
  lsb-release \
  git \
  tilix \
  tmux \
  vim \
  ncdu \
  neofetch \
  htop \
  jq
sudo snap install --classic code


echo "[INFO] Install Docker"

sudo apt-get update
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

if ! getent group docker > /dev/null; then
    sudo groupadd docker
fi

if id "vagrant" &>/dev/null; then
  sudo usermod -aG docker vagrant
fi
sudo usermod -aG docker "$USER"
newgrp docker


echo "[INFO] Install minikube"

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64


echo "[INFO] Install helm"

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm get_helm.sh


echo "[INFO] Clean up"
sudo apt-get clean
rm -rf /var/lib/apt/lists/*



echo "[INFO] Docker version"
docker version
docker compose version


echo "[INFO] Test docker"
docker run --rm hello-world:latest


echo "[INFO] Git version"
git --version


echo "[INFO] Minukube version"
minikube version


echo "[INFO] Helm version"
helm version


echo "[INFO] Manual leftovers"
echo "[INFO] Maybe you still need to add the user to the docker group"
echo "[INFO]   -->  sudo usermod -aG docker \$USER"
