# SwiftUI UI Tests

A framework for data-driven SwiftUI UI testing. Tests define views via codable structs, and the app renders them. UI interactions are logged to files, and tests verify the logs match expected output.

## How It Works

1. Tests define `TestView` with a `ViewBody` (e.g., `.button(text: "demo")`)
2. App launches with the view via environment variable
3. UI interactions write to log files
4. Tests compare generated logs against saved logs

## Usage

```bash
sh run.sh
```

Generates Xcode project with XcodeGen, picks first available iPhone simulator, and runs UI tests.

## Structure

- `SharedCode/` - `TestView` struct and extensions (shared between app and tests)
- `AppCode/` - SwiftUI app that renders test views
- `TestCode/` - XCTest UI tests
- `LogFiles/` - Interaction logs for verification
- `project.yml` - XcodeGen project definition

## Requirements

- macOS
- Xcode
- Swift 6.2+
