#!/bin/bash

set -e

summary() {
  echo 'Rebuild the docker image used for running Autoship commands.'
}

usage() {
  echo 'rebuild-docker'
}

prepare() {
  local project
  local image
  project=`conf-get PROJECT`
  image="ci-autoship:$project"
  log-info "Building CI Autoship docker image '$image'."
  docker build -t $image "$ROOTDIR/docker"
}

main() {
  true
}
