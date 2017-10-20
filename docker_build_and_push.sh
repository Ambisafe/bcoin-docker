#!/bin/bash
set -ex

DOCKER_REPO=ambisafe1/bcoin-node
VERSION=v1.0.0-beta.15

docker build --build-arg 'BCOIN_VERSION='$VERSION -t $DOCKER_REPO:$VERSION .
docker push $DOCKER_REPO:$VERSION
