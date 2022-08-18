import SwiftUI

@main
struct UnaCashTestApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: .init())
                .onAppear { UIApplication.shared.addTapGestureRecognizer() }
        }
    }
}

extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = extKeyWindow else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}

extension UIApplication {
    var extKeyWindow: UIWindow? {
        // Get connected scenes
        UIApplication.shared.connectedScenes
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap { $0 as? UIWindowScene }?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
}
