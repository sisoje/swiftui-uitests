#!/bin/bash
set -e

echo "📦 Generating project..."
swift run xcodegen

echo "🧪 Running UI tests..."
rm -rf TestResults.xcresult
xcodebuild test \
  -project TestApp.xcodeproj \
  -scheme TestApp \
  -destination 'platform=iOS Simulator,name=Any iOS Device' \
  -enableCodeCoverage YES \
  -derivedDataPath .derivedData \
  -resultBundlePath TestResults.xcresult