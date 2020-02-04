//
//  LazyView.swift
//  
//
//  Created by Wolf McNally on 2/3/20.
//

import SwiftUI

/// Used in `NavigationLink`s to avoid eager initialization of destination views.
///
/// - See also: https://medium.com/better-programming/swiftui-navigation-links-and-the-common-pitfalls-faced-505cbfd8029b
public struct LazyView<Content: View>: View {
    let build: () -> Content

    public init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    public var body: Content {
        build()
    }
}
