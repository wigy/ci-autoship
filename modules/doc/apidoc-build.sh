#!/bin/bash

set -e

. "$ROOTDIR/modules/node/common"

summary() {
  echo 'Run build for Apidoc.'
}

usage() {
  echo 'apidoc-build'
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

  node_resolve_dir APIDOC_BUILD_DIR "Select API documentation directory from repo root"
  node_package_manager

  cd "$APIDOC_BUILD_DIR"

  node_resolve_cmd APIDOC_BUILD_CMD "Enter a command to build API documentation" apidoc

  export APIDOC_BUILD_DIR
  export APIDOC_BUILD_CMD
}

main() {
  cd "$TARGET"
  cd $APIDOC_BUILD_DIR
  run-command $NODE_PACKAGE_MANAGER install
  run-command $APIDOC_BUILD_CMD
}
