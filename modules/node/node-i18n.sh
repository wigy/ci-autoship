#!/bin/bash

set -e

. "$ROOTDIR/modules/node/common"

summary() {
  echo 'Build or check i18n files for Node.'
}

usage() {
  echo 'node-i18n'
}

parse_args() {
  if [[ ! -z "$*" ]]; then
    return 1
  fi
}

prepare() {

  . repo-select NODE_

  cd "$TARGET"

  # Resolve test directory.
  node_resolve_dir NODE_I18N_DIR "Select directory with i18n files from root"

  # Set package manager.
  node_package_manager

  # Resolve command.
  cd "$NODE_I18N_DIR"

  node_resolve_cmd NODE_I18N_CMD "Enter a command to build and/or lint i18n files" i18n

  export NODE_I18N_DIR
  export NODE_I18N_CMD
}

main() {
  cd "$TARGET"
  cd $NODE_I18N_DIR
  run-command $NODE_PACKAGE_MANAGER install
  run-command $NODE_I18N_CMD
}
