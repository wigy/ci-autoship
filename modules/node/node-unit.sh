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
  local package_json
  local cmd

  . repo-select NODE_

  cd "$TARGET"

  # Resolve test directory.
  node_resolve_dir NODE_UNIT_DIR "Select unit-test directory from root"

  # Set package manager.
  node_package_manager

  # Resolve command.
  cd "$NODE_UNIT_DIR"

  NODE_UNIT_CMD=`repo-conf-get "$REPO" NODE_UNIT_CMD`
  if [[ -z "$NODE_UNIT_CMD" ]]; then
    if [[ ! -f package.json ]]; then
      error-exit NOT_FOUND "Cannot find package.json. Please define NODE_UNIT_CMD manually."
    fi
    cmd=`jq -r '.scripts.test' < package.json`
    if [[ "$cmd" == null ]]; then
      cmd=''
    else
      cmd="$NODE_PACKAGE_MANAGER test"
    fi
    NODE_UNIT_CMD=`question-str "Enter a command to execute unit tests" "$cmd"`
    repo-conf-set $REPO NODE_UNIT_CMD "$NODE_UNIT_CMD"
  fi

  export NODE_UNIT_DIR
  export NODE_UNIT_CMD
}

main() {
  cd "$TARGET"
  cd $NODE_UNIT_DIR
  run-command $NODE_PACKAGE_MANAGER install
  run-command $NODE_UNIT_CMD
}
