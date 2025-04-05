#!/bin/bash

set -e

summary() {
  echo 'Dummy script for testing.'
}

usage() {
  echo 'dummy'
}

prepare() {
  echo "DUMMY function prepare()"
}

fail() {
  echo "We failed nicely!"
}

success() {
  echo "We succeeded nicely!"
}

main() {
  echo "DUMMY function main()"
  #error-exit NOT_FOUND "Just testing"
}
