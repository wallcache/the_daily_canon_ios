#!/bin/sh
set -e

echo "Installing CocoaPods via Homebrew..."
brew install cocoapods

echo "Running pod install..."
cd "$CI_PRIMARY_REPOSITORY_PATH/ios/App"
pod install
