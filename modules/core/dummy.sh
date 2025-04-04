#!/bin/bash

set -e

summary() {
  echo 'Dummy script for testing.'
}

usage() {
  echo 'dummy'
}

prepare() {
  echo "DUMMY $PLATFORM prepare()"
}

main() {
  echo "DUMMY $PLATFORM main()"
}
