import XCTest

class BaseTestCase: XCTestCase {
    let app = XCUIApplication()
    var savedLog: String?

    var logFile: URL {
        .logFilesDirectory.appendingPathComponent(name).appendingPathExtension("txt")
    }

    override open func setUpWithError() throws {
        continueAfterFailure = false
        if FileManager.default.fileExists(atPath: logFile.path) {
            savedLog = try String(contentsOf: logFile, encoding: .utf8)
        }
        try logFile.makeEmptyFile()
    }

    override open func tearDownWithError() throws {
        guard let savedLog else {
            throw XCTSkip("generating new log")
        }
        let generatedLog = try String(contentsOf: logFile, encoding: .utf8)
        XCTAssertEqual(savedLog, generatedLog, "Wrong content in test: \(name), logfile: \(logFile)")
    }

    func launch(viewBody: TestView.ViewBody) {
        app.launchEnvironment.testView = TestView(logFile: logFile, viewBody: viewBody)
        app.launch()
    }
}
