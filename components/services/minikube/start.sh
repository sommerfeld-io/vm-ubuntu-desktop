#!/bin/bash
# @file start.sh
# @brief Start minikube and enable addons.
# @description
#   This script starts minikube and enables the addons metrics-server, dashboard and ingress. The
#   script starts minikube differently depending on whether it is running in a Vagrantbox or not.


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


echo "[INFO] Running as user $USER"
hostnamectl

echo "[INFO] ========================================================"
echo "[INFO] Documentation website:"
echo "[INFO]   https://sommerfeld-io.github.io/vm-ubuntu"
echo "[INFO] ========================================================"

IS_VAGRANT=false
if [ "$USER" = "vagrant" ]; then
  IS_VAGRANT=true
fi
readonly IS_VAGRANT


if [ "$IS_VAGRANT" = true ]; then
  echo "[INFO] Start minikube in Vagrantbox"
  minikube start --extra-config=apiserver.service-node-port-range=7000-7080 --extra-config=apiserver.bind-address=0.0.0.0
else
  echo "[INFO] Start minikube"
  minikube start
fi

echo "[INFO] Enable addons"
minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable ingress

if [ "$IS_VAGRANT" == true ]; then
  echo "[INFO] Start dashboard with fixed port"
  echo "[INFO] Remember to establish an SSH tunnel before accessing the dashboard through the browser"
  minikube dashboard --port 7999 --url
else
  echo "[INFO] Start dashboard"
  minikube dashboard
fi
