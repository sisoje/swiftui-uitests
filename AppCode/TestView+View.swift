import SwiftUI

extension TestView: View {
    var body: some View {
        switch viewBody {
        case let .button(text):
            Button(text) {
                try! logFile.append("button action")
            }
        }
    }
}
