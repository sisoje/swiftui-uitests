import SwiftUI

@main
struct TestingDemoAppApp: App {
    let body = WindowGroup {
        ProcessInfo.processInfo.environment.testView
    }
}
