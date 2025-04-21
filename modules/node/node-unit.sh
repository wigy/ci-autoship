#!/bin/bash

set -e

. "$ROOTDIR/modules/node/common"

summary() {
  echo 'Run unit tests for Node.'
}

usage() {
  echo 'node-unit'
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
  node_resolve_dir NODE_UNIT_DIR "Select unit-test directory from root"

  # Set package manager.
  node_package_manager

  # Resolve command.
  cd "$NODE_UNIT_DIR"

  node_resolve_cmd NODE_UNIT_CMD "Enter a command to execute unit tests" test

  export NODE_UNIT_DIR
  export NODE_UNIT_CMD
}

main() {
  cd "$TARGET"
  cd $NODE_UNIT_DIR
  run-command $NODE_PACKAGE_MANAGER install
  run-command $NODE_UNIT_CMD
}
