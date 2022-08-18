import Combine
import SwiftUI

final class LoginViewModel: ObservableObject {

    private var item: DispatchWorkItem? = nil

    @Published var name: String = .empty
    @Published var email: String = .empty
    @Published var phone: String = .empty

    @Published var nameFieldState: TextFieldState = .normal
    @Published var emailFieldState: TextFieldState = .normal
    @Published var phoneFieldState: TextFieldState = .normal
    @Published var isKeyboardShown = false
    @Published var disableApplyButton = false

    private var needCancel = false
    private var cancellable: Set<AnyCancellable> = []

    init() {
        setupBindings()
        keyboardNotify()
    }

    func applyButtonTapped() {
        disableApplyButton = true
        clearErrorState()

        item = DispatchWorkItem {
            self.emailFieldState = .error
            self.phoneFieldState = .error
            self.disableApplyButton = false
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: item!)
    }

    func cancelButtonTapped() {
        self.disableApplyButton = false

        DispatchQueue.main.async {
            self.item?.cancel()
        }
    }
}

private extension LoginViewModel {
    func setupBindings() {
        $name
            .sink { [weak self] _ in
                guard self?.nameFieldState == .error else { return }
                self?.nameFieldState = .normal
            }
            .store(in: &cancellable)
        $email
            .sink { [weak self] _ in
                guard self?.emailFieldState == .error else { return }
                self?.emailFieldState = .normal
            }
            .store(in: &cancellable)
        $phone
            .sink { [weak self] _ in
                guard self?.phoneFieldState == .error else { return }
                self?.phoneFieldState = .normal
            }
            .store(in: &cancellable)
    }
    
    func clearErrorState() {
        nameFieldState = .normal
        emailFieldState = .normal
        phoneFieldState = .normal
    }

    func keyboardNotify() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main
        ) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
                withAnimation(.easeInOut) {
                    self?.isKeyboardShown = true
                }
            }
        }
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main
        ) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
                withAnimation(.easeInOut) {
                    self?.isKeyboardShown = false
                }
            }
        }
    }
}
