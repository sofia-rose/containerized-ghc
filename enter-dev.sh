#!/usr/bin/env bash

set -eu

export HOST_WORKSPACE=${HOST_WORKSPACE:-${PWD}}
export CONTAINER_WORKSPACE=/home/ghcuser/workspace

USER_ID=$(id -u)
export USER_ID

GROUP_ID=$(id -g)
export GROUP_ID

IMAGE_REPO=ghc-dev
IMAGE_TAG=latest

docker build \
  --build-arg "USER_ID=${USER_ID}" \
  --build-arg "GROUP_ID=${GROUP_ID}" \
  --file Dockerfile.development \
  --tag "${IMAGE_REPO}:${IMAGE_TAG}" \
  .

docker run \
  --interactive \
  --tty \
  --rm \
  --volume "${HOST_WORKSPACE}:${CONTAINER_WORKSPACE}" \
  --workdir "${CONTAINER_WORKSPACE}" \
  "${IMAGE_REPO}:${IMAGE_TAG}" \
  bash
