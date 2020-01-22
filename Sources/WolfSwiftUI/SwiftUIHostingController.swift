//
//  SwiftUIHostingController.swift
//  
//
//  Created by Wolf McNally on 1/20/20.
//

import UIKit
import SwiftUI

/// A convenience for including a SwiftUI view in a UIKit environment.
public class SwiftUIHostingController: UIHostingController<AnyView> {
    public init<Content: View>(_ host: UIViewController, @ViewBuilder content: () -> Content) {
        super.init(rootView: AnyView(content()))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        host.addChild(self)
        didMove(toParent: host)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
