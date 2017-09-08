#!/usr/bin/env bash

cd ./src
gdbus-codegen --generate-c-code=generated-code org.bluez.xml --interface-prefix org.bluez. --c-generate-object-manager
mv -f ./generated-code.h ../include/generated-code.h