#!/bin/bash
set -e

echo "📦 Generating project..."
swift run xcodegen

# List all iPhone simulators, pick the first one
UDID=$(xcrun simctl list devices |
       grep -w "iPhone" | # filter only iPhone lines
       grep -Eo "[0-9A-Fa-f-]{36}" | # extract UUID
       head -1)

echo "🧪 Running UI tests..."
rm -rf TestResults.xcresult
xcodebuild test \
  -project TestApp.xcodeproj \
  -scheme TestApp \
  -destination id="$UDID" \
  -enableCodeCoverage YES \
  -derivedDataPath .derivedData \
  -resultBundlePath TestResults.xcresult

 