#!/bin/bash
set -x

# https://github.com/ethereum/solidity/releases/download/v${SOLC_VERSION}/solidity_${SOLC_VERSION}.tar.gz

#solc_ver=${SOLC_VERSION}
SOLC_VERSION=0.6.12

# wget -q --show-progress --progress=bar -O solidity_${SOLC_VERSION}.tar.gz https://github.com/ethereum/solidity/releases/download/v${SOLC_VERSION}/solidity_${SOLC_VERSION}.tar.gz
wget -q -O solidity_${SOLC_VERSION}.tar.gz https://github.com/ethereum/solidity/archive/refs/tags/v0.6.12.tar.gz

tar xzf solidity_0.6.12.tar.gz
cd solidity_0.6.12/
echo $PWD

ROOTDIR="$(dirname "$0")/.."
BUILDDIR="${ROOTDIR}/build"
BUILD_TYPE=Release
mkdir -p "${BUILDDIR}"
cd "${BUILDDIR}"

export BUILD_TYPE=Release
export CONFIG_SHELL=/bin/bash
export SOLC_TESTS=Off
export CMAKE_BUILD_TYPE=Release
export MAKEFLAGS=-j10

cmake .. -DCMAKE_BUILD_TYPE="$BUILD_TYPE" "${@:2}"
make -j2

# shellcheck disable=SC2086

echo "[BUILD]: Complete"
git ls-files -o
