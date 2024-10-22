#!/bin/bash
# @file run.sh
# @brief Run InSpec tests.
# @description
#   This script runs the audit tests defined in the InSpec profile to check if the setup is as
#   intended.


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


readonly TAG="5.22.36"
readonly PROFILE="vm-ubuntu"


echo "[INFO] ========================================================"
echo "[INFO] Running as user $USER"
hostnamectl
echo "[INFO] ========================================================"
echo "[INFO] Inspec version"
inspec --version
echo "[INFO] ========================================================"
echo "[INFO] Documentation"
echo "[INFO]   https://sommerfeld-io.github.io/vm-ubuntu"
echo "[INFO] ========================================================"


echo "[INFO] Validate profile $PROFILE"
inspec check "$PROFILE" --chef-license=accept-no-persist

echo "[INFO] Run profile $PROFILE"
inspec exec "$PROFILE" --chef-license=accept-no-persist
