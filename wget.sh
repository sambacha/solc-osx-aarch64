#!/bin/bash

# https://github.com/ethereum/solidity/releases/download/v0.8.12/solidity_0.8.12.tar.gz

solc_ver=0.8.12

wget -q --show-progress --progress=bar -O solidity_0.8.12.tar.gz https://github.com/ethereum/solidity/releases/download/v0.8.12/solidity_0.8.12.tar.gz

tar xzf solidity_0.8.12.tar.gz
cd solidity_0.8.12/
mkdir build
cd build
cmake .. && gmake