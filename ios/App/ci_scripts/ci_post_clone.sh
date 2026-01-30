#!/bin/sh
set -e

echo "Installing Node.js and CocoaPods via Homebrew..."
export HOMEBREW_NO_AUTO_UPDATE=1
brew install node cocoapods

echo "Installing node modules..."
cd "$CI_PRIMARY_REPOSITORY_PATH"
npm install

echo "Syncing Capacitor..."
npx cap sync ios

echo "Running pod install..."
cd "$CI_PRIMARY_REPOSITORY_PATH/ios/App"
pod install
