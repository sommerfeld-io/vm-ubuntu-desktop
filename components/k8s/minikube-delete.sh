#!/bin/bash
# @file minikube-delete.sh
# @brief Delete minikube.
# @description
#   This script deletes minikube.


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

echo "[INFO] Delete minikube"
minikube delete
