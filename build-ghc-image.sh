#!/usr/bin/env bash

set -eu

export GHCUP_VERSION=0.0.8
export GHC_VERSION=8.6.5
export CABAL_VERSION=3.0.0.0

IMAGE_REPO=ghc
IMAGE_TAG="ghc-${GHC_VERSION}-cabal-${CABAL_VERSION}"

docker build \
  --build-arg "GHCUP_VERSION=${GHCUP_VERSION}" \
  --build-arg "GHC_VERSION=${GHC_VERSION}" \
  --build-arg "CABAL_VERSION=${CABAL_VERSION}" \
  --tag "${IMAGE_REPO}:${IMAGE_TAG}" \
  .
