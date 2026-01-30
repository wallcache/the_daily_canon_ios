#!/bin/sh
set -e

echo "Installing CocoaPods..."
export GEM_HOME=$HOME/.gem
export PATH="$GEM_HOME/bin:$PATH"
gem install cocoapods --user-install

echo "Running pod install..."
cd "$CI_PRIMARY_REPOSITORY_PATH/ios/App"
pod install
