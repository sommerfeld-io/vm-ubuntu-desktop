#!/bin/bash
# shellcheck disable=SC1091

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


readonly bashrc="$HOME/.bashrc"


function caption() {
  if [[ -z "${1:-}" ]]; then
    echo "[ERROR] ------------------------------------------------------------------------------"
    echo "[ERROR] No parameter passed to caption function"
    echo "[ERROR] ------------------------------------------------------------------------------"
  exit 1
  fi

  echo "[INFO] -------------------------------------------------------------------------------"
  echo "[INFO] $1"
  echo "[INFO] -------------------------------------------------------------------------------"
}


caption "Update bash prompt"
promptDefinition="\${debian_chroot:+(\$debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ "
grep -qxF "export PS1='${promptDefinition}'" "$bashrc" || echo "export PS1='${promptDefinition}'" >>"$bashrc"

caption "Write aliases"
readonly aliases=(
  'alias ll="ls -alFh --color=auto"'
  'alias ls="ls -a --color=auto"'
  'alias grep="grep --color=auto"'
)
for alias in "${aliases[@]}"; do
  grep -qxF "$alias" "$bashrc" || echo "$alias" >> "$bashrc"
done
