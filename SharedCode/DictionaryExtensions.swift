import Foundation

extension [String: String] {
    private var testViewKey: String { "TEST_VIEW" }

    private var testViewString: String? {
        get { self[testViewKey] }
        set { self[testViewKey] = newValue }
    }

    private var testViewData: Data? {
        get { testViewString.map { Data($0.utf8) } }
        set { testViewString = newValue.map { String(decoding: $0, as: UTF8.self) } }
    }

    var testView: TestView? {
        get { testViewData.flatMap { try? JSONDecoder().decode(TestView.self, from: $0) } }
        set { testViewData = newValue.flatMap { try? JSONEncoder().encode($0) } }
    }
}
