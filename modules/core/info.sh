#!/bin/bash

set -e

summary() {
  echo 'Display the current setup.'
}

usage() {
  echo 'info'
}

prepare() {
  color-print title
  color-print title "CI Autoship setup"
  color-print title
  color-print heading System level variables
  color-print heading
  color-print text MODE=$MODE
  color-print text ROOTDIR=$ROOTDIR
  color-print text WORKDIR=$WORKDIR
  color-print text
  color-print heading Set up
  color-print heading
  color-print text Repositiories: `repo-list`
  color-print text
}
