# SwiftUI Functional Core Tests

> Snapshot testing, but for actions.

A starter template for SwiftUI functional core testing. Clone it, drop it into your project, and customize it to test your views. Tests define views as codable structs, actions are captured as text snapshots, and tests verify the snapshots match saved ones.

## Action Snapshots

Runs in an XCTest UI test target, but it does not check visuals/screenshots. Snapshots are **plain-text action logs**: taps, state changes, effects, lifecycle events.

## Why This Works

A SwiftUI `View` is a data struct, not a view object. The `body` is a computed property that recomposes data into new view values. The framework handles rendering (imperative shell), so the `View` IS the functional core.

By capturing the sequence of actions, these tests verify how initial state behaves through the entire data flow. By strict TDD definitions, this is a unit test — but it runs through UI testing to activate the SwiftUI runtime.

## How It Works

This is **action snapshot testing**:

1. First run: Test executes, actions are logged to a text file (snapshot is created)
2. Test is skipped with "generating new snapshot"
3. Subsequent runs: New snapshot is compared against the saved one
4. Test fails if snapshots don't match (data flow changed)

Similar to Jest snapshots or Swift Snapshot Testing, but for **actions** instead of visual/data output.

**Implementation:**

UI tests run in a separate process from the app. We use `Codable` to serialize the entire view and pass it via environment variable. We use text files for snapshots because both processes can access the filesystem.

1. Tests define `TestView` with a `ViewBody` (e.g., `.button(text: "demo")`)
2. App launches with the view passed via environment variable
3. Actions write to text snapshot files
4. On teardown, tests compare generated snapshots against saved ones

## Usage

1. Clone or download this repository
2. Customize `TestView` and test cases for your app
3. Run tests:

```bash
sh run.sh
```

The script generates the Xcode project with XcodeGen, picks the first available iPhone simulator, and runs tests.

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

Capture any action: taps, swipes, state changes, lifecycle events, text input, etc.

Update snapshots: delete the file in `Snapshots/`, rerun test.

## Requirements

- macOS
- Xcode
- Swift 6.0+

## References

### Functional Core, Imperative Shell

- Gary Bernhardt — [Boundaries](https://www.destroyallsoftware.com/talks/boundaries) (2012) — originated the concept
- Scott Wlaschin — [Moving IO to the edges of your app: Functional Core, Imperative Shell](https://www.youtube.com/watch?v=P1vES9AgfC4)
- Scott Wlaschin — [Functional Design Patterns](https://www.youtube.com/watch?v=srQt1NAHYC0) (NDC London 2014)
- Scott Wlaschin — "Domain Modeling Made Functional" (book)

### SwiftUI Data Flow

- WWDC 2019 — [Data Flow Through SwiftUI](https://developer.apple.com/videos/play/wwdc2019/226/)
- objc.io — [Thinking in SwiftUI](https://www.objc.io/books/thinking-in-swiftui/) (book)
- Point-Free — [pointfree.co](https://www.pointfree.co) — deep dives on SwiftUI architecture and testing

### Snapshot Testing

- Point-Free — [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing)

### TDD

- Kent Beck — "Test Driven Development: By Example" (book)
