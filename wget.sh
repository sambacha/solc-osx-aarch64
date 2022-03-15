#!/bin/bash

# https://github.com/ethereum/solidity/releases/download/v0.8.12/solidity_0.8.12.tar.gz

solc_ver=0.8.12

wget -q --show-progress --progress=bar -O solidity_0.8.12.tar.gz https://github.com/ethereum/solidity/releases/download/v0.8.12/solidity_0.8.12.tar.gz

tar xzf solidity_0.8.12.tar.gz
cd solidity_0.8.12/
mkdir build
cd build
export CONFIG_SHELL=/bin/bash
export SOLC_TESTS=Off
export CMAKE_BUILD_TYPE=Release
export MAKEFLAGS=-j10

cmake .. -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE:-Release}" $CMAKE_OPTIONS -G "Unix Makefiles" -DTESTS=0 -DSOLC_LINK_STATIC=1 && make
git ls-files -o build/
