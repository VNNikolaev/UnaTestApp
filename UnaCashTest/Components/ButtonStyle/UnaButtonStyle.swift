import SwiftUI

public struct UnaButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Self.Configuration) -> some View {
        ContainedButton(configuration: configuration)
    }
}

private extension UnaButtonStyle {
    struct ContainedButton: View {
        @Environment(\.isEnabled) private var isEnabled

        let configuration: UnaButtonStyle.Configuration
        var body: some View {
            configuration.label
                .font(.headline.weight(.medium))
                .foregroundColor(isEnabled ? .mercury : .silver)
                .frame(maxWidth: .infinity)
                .frame(height: .normalButton)
                .background(
                    RoundedRectangle(cornerRadius: .normalCorner)
                        .foregroundColor(isEnabled ? .castIron : .platina)
                        .brightness(configuration.isPressed ? -0.05 : .zero)
                )
        }
    }
}
