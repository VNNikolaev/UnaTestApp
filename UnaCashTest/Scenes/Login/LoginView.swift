import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ScrollView([], showsIndicators: false) {
            logoTitle
            Image("una")
                .resizable()
                .frame(size: viewModel.isKeyboardShown ? 100 : 250)
            textFields
            Spacer()
            buttons
        }
        .padding(.horizontal, .normalGap)
        .background(Color.silver)
    }
}

private extension LoginView {
    var logoTitle: some View {
        HStack(alignment: .top, spacing: .zero) {
            VStack(spacing: .zero) {
                Text("U")
                    .font(.title.weight(.bold))
                Rectangle()
                    .frame(width: 12, height: 2)
            }
            .foregroundColor(.nephritis)

            Text("NA CASH")
                .font(.title.weight(.bold))
                .foregroundColor(.castIron)
            Spacer()
        }
        .padding(.top, .doubleGap)
        .padding(.bottom, viewModel.isKeyboardShown ? .halfGap : 40)
    }
    
    var textFields: some View {
        VStack(spacing: 4) {
            UnaTextField(
                text: $viewModel.name,
                state: $viewModel.nameFieldState,
                placeholder: "Enter Your name",
                errorMessage: "",
                keyboardType: .alphabet
            )
            UnaTextField(
                text: $viewModel.email,
                state: $viewModel.emailFieldState,
                placeholder: "Enter Your email",
                errorMessage: "Email does not exist",
                keyboardType: .emailAddress
            )
            UnaTextField(
                text: $viewModel.phone,
                state: $viewModel.phoneFieldState,
                placeholder: "Enter Your phone number",
                errorMessage: "Enter valid phone",
                keyboardType: .phonePad,
                needPhoneMask: true
            )
        }
    }

    var buttons: some View {
        HStack(spacing: .normalGap) {
            Button("Apply") { viewModel.applyButtonTapped() }
                .buttonStyle(UnaButtonStyle())
                .disabled(viewModel.disableApplyButton)
            Button("Cancel") { viewModel.cancelButtonTapped() }
                .buttonStyle(UnaButtonStyle())
        }
        .padding(.bottom, .normalGap)
    }
}
