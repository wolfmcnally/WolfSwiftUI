import SwiftUI
import Combine

// MARK: - A View that offers to fill all available space at a high priority.

struct Greedy<Content> : View where Content : View {
    let layoutPriority: Double
    let content: Content

    init(_ layoutPriority: Double = 1, @ViewBuilder content: () -> Content) {
        self.layoutPriority = layoutPriority
        self.content = content()
    }

    var body: some View {
        GeometryReader { _ in
            self.content
        }
        .layoutPriority(layoutPriority)
    }
}

// MARK: - Flip environment right-to-left

extension View {
    func rightToLeft() -> some View {
        return self
            .environment(\.layoutDirection, .rightToLeft)
    }
}

// MARK: - Erase to AnyView

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

// MARK: - Project Optional Binding to Non-Optional Binding

func ??<T>(binding: Binding<T?>, fallback: T) -> Binding<T> {
    return Binding(get: {
        binding.wrappedValue ?? fallback
    }, set: {
        binding.wrappedValue = $0
    })
}

// MARK: - Fix Vertical Height

extension View {
    func fixedVertical() -> some View {
        fixedSize(horizontal: false, vertical: true)
    }
}

// MARK: - Dark Mode

struct DarkMode: ViewModifier {
    func body(content: Content) -> some View {
        content.environment(\.colorScheme, .dark)
    }
}

extension View {
    func darkMode() -> some View {
        modifier(DarkMode())
    }
}

struct LightMode: ViewModifier {
    func body(content: Content) -> some View {
        content.environment(\.colorScheme, .light)
    }
}

extension View {
    func lightMode() -> some View {
        modifier(LightMode())
    }
}

// MARK: - Tap Dismisses Keyboard

struct TapDismissesKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}

extension View {
    func tapDismissesKeyboard() -> some View {
        modifier(TapDismissesKeyboard())
    }

    func endEditing(_ force: Bool = false) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
    }
}

// MARK: - Adapts to Screen Keyboard

struct AdaptsToScreenKeyboard: ViewModifier {
    @State var currentHeight: CGFloat = 0
    @State var cancellable: AnyCancellable?

    func body(content: Content) -> some View {
        content
            .padding(.bottom, currentHeight).animation(.easeOut(duration: 0.25))
            .edgesIgnoringSafeArea(currentHeight == 0 ? Edge.Set() : .bottom)
            .onAppear(perform: startWatchingKeyboard)
            .onDisappear(perform: stopWatchingKeyboard)
    }

    private let keyboardHeightOnOpening = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect }
        .map { $0.height }


    private let keyboardHeightOnHiding = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat(0) }

    private func startWatchingKeyboard() {
        //print("🔥 startWatchingKeyboard")
        cancellable = Publishers.Merge(keyboardHeightOnOpening, keyboardHeightOnHiding)
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { height in
                if self.currentHeight == 0 || height == 0 {
                    self.currentHeight = height
                }
        }
    }

    private func stopWatchingKeyboard() {
        //print("🔥 stopWatchingKeyboard")
        cancellable?.cancel()
    }
}

extension View {
    func adaptsToScreenKeyboard() -> some View {
        modifier(AdaptsToScreenKeyboard())
    }
}

// MARK: - DisabledField

struct DisabledField: ViewModifier {
    let isDisabled: Bool

    func body(content: Content) -> some View {
        content
        .disabled(isDisabled)
            .foregroundColor(isDisabled ? Color.secondary : Color.primary)
    }
}

extension View {
    func disabledField(_ isDisabled: Bool) -> some View {
        modifier(DisabledField(isDisabled: isDisabled))
    }
}
