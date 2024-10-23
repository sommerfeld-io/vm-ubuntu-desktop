#!/bin/bash
# @file minikube-dashboard.sh
# @brief Start the minikube dashboard.
# @description
#   This script starts the minikube dashboard. The script provides additional information when
#   running in a Vagrantbox.


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

IS_VAGRANT=false
if [ "$USER" = "vagrant" ]; then
  IS_VAGRANT=true
fi
readonly IS_VAGRANT

echo "[INFO] Start dashboard"
readonly DASHBOARD_PORT="7999"
if [ "$IS_VAGRANT" == true ]; then
  echo "[INFO] ========================================================"
  echo "[INFO] Remember to establish an SSH tunnel before accessing the"
  echo "[INFO] dashboard through the browser"
  echo "[INFO]   vagrant ssh -- -L $DASHBOARD_PORT:localhost:$DASHBOARD_PORT"
  echo "[INFO] ========================================================"
fi
minikube dashboard --port "$DASHBOARD_PORT"
