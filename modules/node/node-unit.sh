#!/bin/bash

set -e

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
    NODE_UNIT_DIR=`question-dir "Select unit-test directory (type '.' for root dir)" "$local_path"`

    repo-conf-set $REPO NODE_UNIT_DIR "$NODE_UNIT_DIR"
  fi

  # Resolve command.
  cd "$NODE_UNIT_DIR"

  NODE_UNIT_CMD=`repo-conf-get "$REPO" NODE_UNIT_CMD`
  if [[ -z "$NODE_UNIT_CMD" ]]; then
    cmd=`jq -r '.scripts.test' < package.json`
    if [[ "$cmd" == null ]]; then
      cmd=''
    else
      cmd="yarn test"
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
  yarn install # TODO: Configure NODE_PACKAGE_MANAGER
  $NODE_UNIT_CMD
}
