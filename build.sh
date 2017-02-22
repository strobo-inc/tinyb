#!/usr/bin/env bash

set -ex

docker build -f Dockerfile.arm -t tinyb --rm .
docker run --name tinyb tinyb
docker cp tinyb:/work/build .
