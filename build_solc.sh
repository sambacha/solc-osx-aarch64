#!/bin/bash

export SOLC_TESTS=Off
export CMAKE_BUILD_TYPE=Release
export MAKEFLAGS=-j10
#  date -u +"nightly.%Y.%-m.%-d" > prerelease.txt
echo -n > prerelease.txt
echo -n "$GITHUB_COMMIT" > commit_hash.txt