#!/bin/bash

set -e

summary() {
  echo 'Study available commands.'
}

usage() {
  echo 'help [<task>]'
}

parse_args() {
  if [[ $# -gt 1 ]]; then
    return 1
  fi
  export TASK=$1
}

prepare() {
  local module
  local task
  local scripts

  if [[ "$TASK" == '' ]]; then
    color-print title
    color-print title "CI Autoship Modules"
    for module in "$ROOTDIR/modules"/*; do
      color-print heading
      color-print heading "  `basename $module`"
      color-print heading
      for task in "$module"/*.sh; do
        . $task
        color-print text "    `basename $task .sh` - `summary`"
      done
    done
    color-print text

    scripts=`script-list`
    if [[ ! -z "$scripts" ]]; then
      color-print title
      color-print title "CI Autoship Scripts"
      color-print title
      color-print text "    $scripts"
      color-print text
    fi

    if [[ "`repo-list`" == '' ]]; then
      color-print note '+---------------------------------------------------------------------------+'
      color-print -n note '| Note! No repositories yet. You can add one using '
      color-print -n code './ci repo add <git-repo>'
      color-print note ' |'
      color-print note '+---------------------------------------------------------------------------+'
      color-print note
    fi
  else
    if task-exists "$TASK"; then
      color-print title
      color-print title "Task $TASK"
      color-print title
      . task-load "$TASK"
      color-print text `summary`
      color-print text
      color-print heading Usage:
      color-print text
      usage
      color-print text
    else
      error-exit NOT_FOUND "No such task as '$TASK'."
    fi
  fi
}

main() {
  true
}
