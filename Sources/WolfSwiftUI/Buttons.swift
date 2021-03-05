//
//  Buttons.swift
//  
//
//  Created by Wolf McNally on 1/22/20.
//

import SwiftUI

public struct DetailToggleButton: View {
    @Binding var isDetailVisible: Bool

    public init(isDetailVisible: Binding<Bool>) {
        self._isDetailVisible = isDetailVisible
    }

    public var body: some View {
        Button(action: {
            withAnimation {
                self.isDetailVisible.toggle()
            }
        }) {
            Image(systemName: "chevron.right.circle")
                .rotationEffect(.degrees(isDetailVisible ? 90 : 0))
                .flipsForRightToLeftLayoutDirection(true)
        }
    }
}

public struct CheckBox: View {
    let title: String
    @Binding var isOn: Bool

    public init(title: String, isOn: Binding<Bool>) {
        self.title = title
        self._isOn = isOn
    }

    public var body: some View {
        Button(action: {
            self.isOn.toggle()
        }) {
            Image(systemName: isOn ? "checkmark.square.fill": "square")
            .imageScale(.large)
        }
    }
}

public struct RefreshButton: View {
    @Binding var isRefreshing: Bool
    let onRefresh: () -> Void

    public init(isRefreshing: Binding<Bool>, onRefresh: @escaping () -> Void) {
        self._isRefreshing = isRefreshing
        self.onRefresh = onRefresh
    }

    public var body: some View {
        Group {
            if isRefreshing {
                ActivityIndicator(isAnimating: .constant(true), style: .medium)
            } else {
                Button(action: onRefresh) {
                    Image(systemName: "arrow.clockwise")
                        .flipsForRightToLeftLayoutDirection(true)
                }
            }
        }
    }
}

public struct CancelButton: View {
    let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public init(_ isPresented: Binding<Bool>) {
        self.init {
            isPresented.wrappedValue = false
        }
    }

    public var body: some View {
        Button(action: action) {
            Text("Cancel")
        }
    }
}

public struct DoneButton: View {
    let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public init(_ isPresented: Binding<Bool>) {
        self.init {
            isPresented.wrappedValue = false
        }
    }

    public var body: some View {
        Button(action: action) {
            Text("Done")
                .bold()
        }
    }
}

public struct SaveButton: View {
    let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text("Save")
                .bold()
        }
    }
}

public struct BackButton: View {
    let label: String
    let action: () -> Void

    public init(label: String = "Back", action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .flipsForRightToLeftLayoutDirection(true)
                Text(label)
                .bold()
            }
        }
    }
}

#if DEBUG

struct Buttons_Previews: PreviewProvider {
    struct Preview: View {
        @State var isDetailVisible = false
        @State var isChecked = false
        @State var isRefreshing = false

        var body: some View {
            VStack(spacing: 30) {
                HStack(spacing: 20) {
                    DetailToggleButton(isDetailVisible: $isDetailVisible)
                    CheckBox(title: "Checked", isOn: $isChecked)
                    RefreshButton(isRefreshing: $isRefreshing) {
                        self.isRefreshing = true
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now().advanced(by: .seconds(1))) {
                            self.isRefreshing = false
                        }
                    }
                }
                DoneButton() { }
                BackButton() { }
            }
            .padding()
        }
    }

    static var previews: some View {
        NavigationView {
            Preview()
        }
        .darkMode()
        .navigationViewStyle(StackNavigationViewStyle())
        //.rightToLeft()
    }
}

#endif
