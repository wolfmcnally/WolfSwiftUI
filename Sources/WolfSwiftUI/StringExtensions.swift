import SwiftUI
import Foundation

public extension String {
    var markdownAttributed: AttributedString {
        try! AttributedString(markdown: self, options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))
    }
}

public extension Text {
    init(markdown: any StringProtocol) {
        self.init(String(markdown).markdownAttributed)
    }
}
