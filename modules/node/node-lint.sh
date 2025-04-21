#!/bin/bash

set -e

. "$ROOTDIR/modules/node/common"

summary() {
  echo 'Run linting for Node.'
}

usage() {
  echo 'node-lint'
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

  # Resolve test directory.
  node_resolve_dir NODE_LINT_DIR "Select linting directory from repo root"

  # Set package manager.
  node_package_manager

  # Resolve command.
  cd "$NODE_LINT_DIR"

  node_resolve_cmd NODE_LINT_CMD "Enter a command to execute linting" lint

  export NODE_LINT_DIR
  export NODE_LINT_CMD
}

main() {
  cd "$TARGET"
  cd $NODE_LINT_DIR
  run-command $NODE_PACKAGE_MANAGER install
  run-command $NODE_LINT_CMD
}
