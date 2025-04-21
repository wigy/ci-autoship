#!/bin/bash

set -e

. "$ROOTDIR/modules/node/common"

summary() {
  echo 'Run build for Node.'
}

usage() {
  echo 'node-build'
}

parse_args() {
  if [[ ! -z "$*" ]]; then
    return 1
  fi
}

prepare() {
  local package_json
  local cmd

  . repo-select NODE_

  cd "$TARGET"

  node_resolve_dir NODE_BUILD_DIR "Select building directory from repo root"
  node_package_manager

  cd "$NODE_BUILD_DIR"

  node_resolve_cmd NODE_BUILD_CMD "Enter a command to execute building" build

  export NODE_BUILD_DIR
  export NODE_BUILD_CMD
}

main() {
  cd "$TARGET"
  cd $NODE_BUILD_DIR
  run-command $NODE_PACKAGE_MANAGER install
  run-command $NODE_BUILD_CMD
}
