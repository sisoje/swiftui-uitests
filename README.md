# SwiftUI Interaction UI Tests

> Snapshot testing, but for actions.

A starter template for SwiftUI UI interaction testing. Clone it, drop it into your project, and customize it to test your views. Tests define views as codable structs, user interactions are captured as text snapshots, and tests verify the snapshots match saved ones.

## Snapshot Testing

This is **interaction snapshot testing**:

1. First run: Test executes, interactions are logged to a text file (snapshot is created)
2. Test is skipped with "generating new snapshot"
3. Subsequent runs: New snapshot is compared against the saved one
4. Test fails if snapshots don't match (behavior changed)

Similar to Jest snapshots or Swift Snapshot Testing, but for **user interactions** instead of visual/data output.

## How It Works

1. Tests define `TestView` with a `ViewBody` (e.g., `.button(text: "demo")`)
2. App launches with the view passed via environment variable
3. UI interactions (taps, swipes, state changes, lifecycle events like `onAppear`) write to text snapshot files
4. On teardown, tests compare generated snapshots against saved ones

## Usage

1. Clone or download this repository
2. Customize `TestView` and test cases for your app
3. Run tests:

```bash
sh run.sh
```

The script generates the Xcode project with XcodeGen, picks the first available iPhone simulator, and runs UI tests.

To test your own package, uncomment the `packages` section in `project.yml`.

## Structure

- `SharedCode/` - `TestView` struct and extensions (shared between app and tests)
- `AppCode/` - SwiftUI app that renders test views
- `TestCode/` - XCTest UI tests
- `Snapshots/` - Text snapshots for verification
- `project.yml` - XcodeGen project definition

## Extending

Add view types in `SharedCode/TestView.swift`:

```swift
enum ViewBody: Codable {
    case button(text: String)
    case yourType(param: String)
}
```

Implement in `AppCode/TestView+View.swift`:

```swift
case let .yourType(param):
    YourView(param) {
        try! logFile.append("action")
    }
    .onAppear {
        try! logFile.append("appeared")
    }
```

Capture any interaction: taps, swipes, state changes, lifecycle events, text input, etc.

Update snapshots: delete the file in `Snapshots/`, rerun test.

## Requirements

- macOS
- Xcode
- Swift 6.0+
