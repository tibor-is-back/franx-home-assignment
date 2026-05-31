import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Fonts.body.weight(.semibold))
            .foregroundStyle(DesignSystem.Colors.primary)
            .opacity(configuration.isPressed ? DesignSystem.Opacity.pressedPlain : DesignSystem.Opacity.full)
    }
}

extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: SecondaryButtonStyle { SecondaryButtonStyle() }
}

#Preview("Retry Button") {
    Button("Retry") {}
        .buttonStyle(.secondary)
        .padding(DesignSystem.Spacing.medium)
        .frame(maxWidth: .infinity)
        .background(DesignSystem.Colors.screenBackground)
}

#Preview("Retry Button – Dark") {
    Button("Retry") {}
        .buttonStyle(.secondary)
        .padding(DesignSystem.Spacing.medium)
        .frame(maxWidth: .infinity)
        .background(DesignSystem.Colors.screenBackground)
        .preferredColorScheme(.dark)
}
