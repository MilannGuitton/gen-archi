#!/bin/bash

set -e

export WORKDIR=$(pwd)
export LAYER_MYSQL="layer_pymysql"

#Init Packages Directory
mkdir -p packages/

# Building pymysql layer
cd ${WORKDIR}/${LAYER_MYSQL}/
./build_layer.sh

zip -r ${WORKDIR}/packages/python3-pymysql.zip .
rm -rf ${WORKDIR}/${LAYER_MYSQL}/python/
