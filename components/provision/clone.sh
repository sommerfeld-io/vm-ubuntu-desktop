#!/bin/bash
# @file clone.sh
# @brief Clone repositories.
# @description
#   This script prepares the directory structure and clones all relevant repositories.


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


readonly REPOS_DIR="$HOME/work/repos"


echo "[INFO] Setup Directory Structure and clone repositories"

mkdir -p "$REPOS_DIR"

(
  cd "$REPOS_DIR" || exit
  git clone https://github.com/sommerfeld-io/vm-ubuntu-desktop.git
)
