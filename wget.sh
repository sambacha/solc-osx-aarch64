#!/bin/bash
set -x

# https://github.com/ethereum/solidity/releases/download/v${SOLC_VERSION}/solidity_${SOLC_VERSION}.tar.gz

#solc_ver=${SOLC_VERSION}
SOLC_VERSION=0.6.12

# wget -q --show-progress --progress=bar -O solidity_${SOLC_VERSION}.tar.gz https://github.com/ethereum/solidity/releases/download/v${SOLC_VERSION}/solidity_${SOLC_VERSION}.tar.gz
wget -q -O solidity_${SOLC_VERSION}.tar.gz https://github.com/ethereum/solidity/archive/refs/tags/v0.6.12.tar.gz

tar xzf solidity_${SOLC_VERSION}.tar.gz
cd solidity_${SOLC_VERSION}/
mkdir -p build
cd build

export BUILD_TYPE=Release
export CONFIG_SHELL=/bin/bash
export SOLC_TESTS=Off
export CMAKE_BUILD_TYPE=Release
export MAKEFLAGS=-j10

# shellcheck disable=SC2086
cmake .. -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE:-Release}" $CMAKE_OPTIONS -G "Unix Makefiles" -DTESTS=0 -DSOLC_LINK_STATIC=1 && make -j2
echo "[BUILD]: Complete"
git ls-files -o solc/

# while our scripts pass linting, other scripts may not
# /home/travis/.travis/job_stages: line 81: secure: unbound
set +u
