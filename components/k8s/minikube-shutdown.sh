#!/bin/bash
# @file minikube-shutdown.sh
# @brief Stop minikube.
# @description
#   This script shuts minikube down.


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


echo "[INFO] ========================================================"
echo "[INFO] Running as user $USER"
hostnamectl
echo "[INFO] ========================================================"
echo "[INFO] Documentation"
echo "[INFO]   https://sommerfeld-io.github.io/vm-ubuntu"
echo "[INFO] ========================================================"

echo "[INFO] Stop minikube"
minikube stop
