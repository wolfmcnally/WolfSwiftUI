//
//  Placeholder.swift
//  
//
//  Created by Wolf McNally on 1/20/20.
//

import SwiftUI

public struct Placeholder: View {
    let title: String?

    public init(_ title: String? = nil) {
        self.title = title
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                CrossedBox()
                    .stroke(Color(white: 0.5).opacity(0.5))
                    .background(Color(white: 0.5).opacity(0.1))
                if self.title != nil {
                    Text(self.title!)
                        .foregroundColor(Color(white: 0.5).opacity(0.8))
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                        .padding(5)
                }
            }.frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

struct Placeholder_Previews: PreviewProvider {
    static var previews: some View {
        Placeholder("Placeholder").frame(height: 150)
    }
}
