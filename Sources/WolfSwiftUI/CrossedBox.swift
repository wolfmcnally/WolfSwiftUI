//
//  CrossedBox.swift
//  
//
//  Created by Wolf McNally on 1/20/20.
//

import SwiftUI

public struct CrossedBox: Shape {
    
    public init() { }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()

        path.addRect(rect)
        path.addLines([rect.minXminY, rect.maxXmaxY])
        path.addLines([rect.minXmaxY, rect.maxXminY])

        return path
    }
}

extension CGRect {
    // Corners
    var minXminY: CGPoint { return CGPoint(x: minX, y: minY) }
    var maxXminY: CGPoint { return CGPoint(x: maxX, y: minY) }
    var maxXmaxY: CGPoint { return CGPoint(x: maxX, y: maxY) }
    var minXmaxY: CGPoint { return CGPoint(x: minX, y: maxY) }
}
