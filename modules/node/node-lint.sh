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

  NODE_LINT_CMD=`repo-conf-get "$REPO" NODE_LINT_CMD`
  if [[ -z "$NODE_LINT_CMD" ]]; then
    if [[ ! -f package.json ]]; then
      error-exit NOT_FOUND "Cannot find package.json. Please define NODE_LINT_CMD manually."
    fi
    cmd=`jq -r '.scripts.lint' < package.json`
    if [[ "$cmd" == null ]]; then
      cmd=''
    else
      cmd="$NODE_PACKAGE_MANAGER lint"
    fi
    NODE_LINT_CMD=`question-str "Enter a command to execute linting" "$cmd"`
    repo-conf-set $REPO NODE_LINT_CMD "$NODE_LINT_CMD"
  fi

  export NODE_LINT_DIR
  export NODE_LINT_CMD
}

main() {
  cd "$TARGET"
  cd $NODE_LINT_DIR
  run-command $NODE_PACKAGE_MANAGER install
  run-command $NODE_LINT_CMD
}
