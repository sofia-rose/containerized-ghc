#!/usr/bin/env bash

set -eu

export HOST_WORKSPACE=${HOST_WORKSPACE:-${PWD}}

USER_ID=$(id -u)
export USER_ID

GROUP_ID=$(id -g)
export GROUP_ID

export GHCUP_VERSION=0.0.8
export GHC_VERSION=8.6.5
export CABAL_VERSION=3.0.0.0

IMAGE_TAG="ghc:ghc-${GHC_VERSION}-cabal-${CABAL_VERSION}"

docker build \
  --build-arg "USER_ID=${USER_ID}"  \
  --build-arg "GROUP_ID=${GROUP_ID}" \
  --build-arg "GHCUP_VERSION=${GHCUP_VERSION}" \
  --build-arg "GHC_VERSION=${GHC_VERSION}" \
  --build-arg "CABAL_VERSION=${CABAL_VERSION}" \
  --tag ${IMAGE_TAG} \
  .

docker run \
  --interactive \
  --tty \
  --rm \
  --volume "${HOST_WORKSPACE}:/home/theuser/workspace" \
  "${IMAGE_TAG}" \
  /bin/bash
