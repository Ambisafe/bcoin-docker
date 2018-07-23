#!/bin/bash
set -ex

DOCKER_REPO=ambisafe1/bcoin-node
VERSION=v1.0.2

docker build --no-cache --build-arg 'BCOIN_VERSION='$VERSION -t $DOCKER_REPO:$VERSION .
docker push $DOCKER_REPO:$VERSION