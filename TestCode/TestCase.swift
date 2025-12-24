import XCTest

final class TestCase: BaseTestCase {
    func testButton() throws {
        launch(viewBody: .button(text: "demo"))

        let button = app.buttons["demo"]
        XCTAssertTrue(button.exists, "Button with label 'demo' should exist")
        XCTAssertTrue(button.isHittable, "Button should be hittable")

        button.tap()
    }
}
