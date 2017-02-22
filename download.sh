#!/usr/bin/env bash

set -ex

docker pull strobo/tinyb
docker run --name tinyb strobo/tinyb
docker cp tinyb:/work/build .
