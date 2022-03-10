#!/bin/bash

set -x
echo $BASH_VERSION

VERSION=v0.8.10

git clone https://github.com/ethereum/solidity --branch v0.8.10 --single-branch solidity
cd solidity/
echo "building $VERSION"
echo "Starting..."
TZ=UTC git show --quiet --date="format-local:%Y.%-m.%-d" --format="ci.%cd" >prerelease.txt
echo -n "$GITHUB_COMMIT" > commit_hash.txt

mkdir -p build
cd build
echo "Starting source build...."
export SOLC_TESTS=Off
export CMAKE_BUILD_TYPE=Release
export MAKEFLAGS=-j10

cmake .. -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE:-Release}" $CMAKE_OPTIONS -G "Unix Makefiles" -DTESTS=0 -DSOLC_LINK_STATIC=1

gmake

sleep 1

exit 0