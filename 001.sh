#!/bin/bash
VERSION=v0.8.10

git clone https://github.com/ethereum/solidity --branch v0.8.10 --single-branch solidity
cd solidity/
echo "building $VERSION"
echo "Starting..."
TZ=UTC git show --quiet --date="format-local:%Y.%-m.%-d" --format="ci.%cd" >prerelease.txt

mkdir -p build
cd build
echo "Starting source build...."

cmake .. -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE:-Release}" $CMAKE_OPTIONS -G "Unix Makefiles" -DTESTS=0 -DSOLC_LINK_STATIC=1

gmake