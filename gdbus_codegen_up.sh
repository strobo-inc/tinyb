#!/usr/bin/env bash

set -ex

docker build -f gdbus-codegen-Dockerfile -t tinyb_gdbus_codegen --rm .
docker run --name tinyb_gdbus_codegen tinyb_gdbus_codegen
docker cp tinyb_gdbus_codegen:/work/src/generated-code.c ./src/generated-code.c
docker cp tinyb_gdbus_codegen:/work/include/generated-code.h ./include/generated-code.h