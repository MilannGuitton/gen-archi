#!/bin/bash

set -e

export PKG_DIR="python"
rm -rf ${PKG_DIR} && mkdir -p ${PKG_DIR}
pip3 install -r requirements.txt --no-deps -t ${PKG_DIR}
