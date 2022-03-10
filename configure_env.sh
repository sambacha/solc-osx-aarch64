#!/bin/bash

echo "SDKROOT=$(xcrun -sdk macosx11.1 --show-sdk-path)" >> $GITHUB_ENV
echo "MACOSX_DEPLOYMENT_TARGET=$(xcrun -sdk macosx11.1 --show-sdk-platform-version)" >> $GITHUB_ENV
