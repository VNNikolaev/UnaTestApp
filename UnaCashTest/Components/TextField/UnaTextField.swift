import Combine
import SwiftUI

enum TextFieldState {
    case normal
    case error
}

struct UnaTextField: View {
    @Binding var text: String
    @Binding var state: TextFieldState

    let placeholder: String
    let errorMessage: String
    let keyboardType: UIKeyboardType
    var needPhoneMask: Bool

    init(
        text: Binding<String>,
        state: Binding<TextFieldState> = .constant(.normal),
        placeholder: String,
        errorMessage: String,
        keyboardType: UIKeyboardType,
        needPhoneMask: Bool = false
    ) {
        _text = text
        _state = state
        self.placeholder = placeholder
        self.errorMessage = errorMessage
        self.keyboardType = keyboardType
        self.needPhoneMask = needPhoneMask
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(placeholder)
                .font(.headline.weight(.medium))
                .foregroundColor(.alluminium)
                .padding(.leading)
                .opacity($text.wrappedValue.isEmpty ? 0 : 1)
                .offset(y: $text.wrappedValue.isEmpty ? 20 : 0)
            TextField(placeholder, text: $text)
                .accentColor(.alluminium)
                .padding()
                .frame(height: .doubleGap)
                .background(Color.mercury)
                .disableAutocorrection(true)
                .cornerRadius(.smallCorner)
                .overlay {
                    RoundedRectangle(cornerRadius: .smallCorner)
                        .strokeBorder(state == .error ? Color.coral : Color.nephritis)
                }
                .keyboardType(keyboardType)
                .foregroundColor(.castIron)
                .onReceive(Just(text)) {
                    generateMask($0)
                }
            Text(errorMessage)
                .font(.headline.weight(.medium))
                .foregroundColor(.coral)
                .padding(.leading)
                .opacity(state == .normal ? 0 : 1)
                .offset(y: state == .normal ? -20 : 0)
        }
        .animation(.default)
    }
}

private extension UnaTextField {
    func getPhonePrefix(_ string: String) -> String {
        switch string {
        case "7", "8":
            return "+7 ("
        default:
            return string
        }
    }

    func generateMask(_ value: String) {
        guard needPhoneMask, !value.isEmpty else { return }
        guard value != "+7 " else {
            text = .empty
            return
        }
        let formatString = getPhonePrefix(value)
            .deletingPrefix("+7")
            .applyPatternOnNumbers(pattern: "###) ###-##-##")
        let string = "+7 (" + formatString
        if value != string {
            text = string
        }
    }
}
