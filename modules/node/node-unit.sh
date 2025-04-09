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

  cd "$WORKDIR"/.autoship/repos/$REPO/branches/$BRANCH

  # Resolve test directory.
  NODE_UNIT_DIR=`repo-conf-get "$REPO" NODE_UNIT_DIR`
  if [[ -z "$NODE_UNIT_DIR" ]]; then
    package_json=`find "$WORKDIR" -name 'package.json' | head -n 1`
    if [[ -z "$package_json" ]]; then
      error-exit NOT_FOUND "Unable to find any directory with package.json file."
    fi
    local_path=`dirname ${package_json/"$WORKDIR/.autoship/repos/$REPO/branches/$BRANCH/"}`
    NODE_UNIT_DIR=`question-dir "Select unit-test directory from root (type '.' for root dir)" "$local_path"`

    repo-conf-set $REPO NODE_UNIT_DIR "$NODE_UNIT_DIR"
  fi

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
  cd "$WORKDIR"/.autoship/repos/$REPO/branches/$BRANCH
  cd $NODE_UNIT_DIR
  run-command $NODE_PACKAGE_MANAGER install
  run-command $NODE_UNIT_CMD
}
