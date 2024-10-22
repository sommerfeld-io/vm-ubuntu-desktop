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


echo "[INFO] ========================================================"
echo "User     = $USER"
echo "Hostname = $HOSTNAME"
echo "Home dir = $HOME"
hostnamectl
echo "[INFO] ========================================================"


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
sudo rm -rf /var/lib/apt/lists/*



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


echo "[INFO] Setup folders"
readonly base_dir="/opt/vm-ubuntu"
readonly folders=(
  "$base_dir"
  '/opt/vm-ubuntu/portainer'
)
for f in "${folders[@]}"; do
  sudo mkdir -p "$f"
done


echo "[INFO] Download minikube scripts from repository"
sudo curl -fsSL -o "$base_dir/minikube-start.sh" https://raw.githubusercontent.com/sommerfeld-io/vm-ubuntu/refs/heads/main/components/k8s/minikube-start.sh
sudo chmod 755 "$base_dir/minikube-start.sh"

echo "[INFO] Download Docker Compose config for Portainer from repository"
sudo curl -fsSL -o "$base_dir/portainer/docker-compose.yml" https://raw.githubusercontent.com/sommerfeld-io/vm-ubuntu/refs/heads/main/components/portainer/docker-compose.yml

echo "[INFO] Set permissions in $base_dir"
sudo chmod -R 644 "$base_dir"
sudo find "$base_dir" -type f -name "*.sh" -exec sudo chmod 755 {} \;
sudo chown -R "$(id -u):$(id -g)" "$base_dir"

echo "[INFO] ========================================================"
echo "[INFO] Maybe you still need to add the user to the docker group"
echo "[INFO]   sudo usermod -aG docker \$USER"
echo "[INFO]"
echo "[INFO] Documentation website: "
echo "[INFO]   https://sommerfeld-io.github.io/vm-ubuntu"
echo "[INFO] ========================================================"
