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


echo "[INFO] ========================================================"
echo "[INFO] Running as user $USER"
hostnamectl
echo "[INFO] ========================================================"
echo "[INFO] Inspec version"
docker run -it --rm chef/inspec:5.22.58 --version
echo "[INFO] ========================================================"
echo "[INFO] Documentation"
echo "[INFO]   https://sommerfeld-io.github.io/vm-ubuntu"
echo "[INFO] ========================================================"


readonly PROFILE="vm-ubuntu"


echo "[INFO] Validate $PROFILE"
docker run -it --rm \
    --volume "$(pwd):$(pwd)" \
    --workdir "$(pwd)" \
    chef/inspec:5.22.58 check "$PROFILE" --chef-license=accept-no-persist

echo "[INFO] Run profile $PROFILE"
docker run -it --rm \
    --volume "$(pwd):$(pwd)" \
    --workdir "$(pwd)" \
    chef/inspec:5.22.58 exec "$PROFILE" --chef-license=accept-no-persist
