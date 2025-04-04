#!/bin/bash

set -e

summary() {
  echo 'Repository management.'
}

usage() {
  echo -e 'repo ls\nrepo add <url> [<branch>]'
}

parse_args() {
  case "$1" in
    add)
      if [[ $# -gt 3 ]]; then
        return 1
      fi
      if [[ $# -lt 2 ]]; then
        return 1
      fi
      export REPO=$2
      export BRANCH=$3
    ;;
    ls)
      if [[ $# -gt 1 ]]; then
        return 1
      fi
    ;;
    *)
    return 1
  esac

  export COMMAND=$1
}

prepare() {
  case "$COMMAND" in
    ls)
      repo-list
    ;;
    add)
      repo-create "$REPO" "$BRANCH"
    ;;
  esac
}

main() {
  true
}
