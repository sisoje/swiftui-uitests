import Foundation

struct TestView: Codable {
    enum ViewBody: Codable {
        case button(text: String)
    }

    let logFile: URL
    let viewBody: ViewBody
}
