#!/bin/bash

set -x

# https://github.com/ethereum/solidity/releases/download/v${SOLC_VERSION}/solidity_${SOLC_VERSION}.tar.gz

#solc_ver=${SOLC_VERSION}
SOLC_VERSION=0.7.6

wget -q --show-progress --progress=bar -O solidity_${SOLC_VERSION}.tar.gz https://github.com/ethereum/solidity/releases/download/v${SOLC_VERSION}/solidity_${SOLC_VERSION}.tar.gz

tar xzf solidity_${SOLC_VERSION}.tar.gz
cd solidity_${SOLC_VERSION}/
mkdir -p build
cd build
export CONFIG_SHELL=/bin/bash
export SOLC_TESTS=Off
export CMAKE_BUILD_TYPE=Release
export MAKEFLAGS=-j10

cmake .. -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE:-Release}" $CMAKE_OPTIONS -G "Unix Makefiles" -DTESTS=0 -DSOLC_LINK_STATIC=1 && make
git ls-files -o solc/

exit 0

# while our scripts pass linting, other scripts may not
# /home/travis/.travis/job_stages: line 81: secure: unbound
set +u
