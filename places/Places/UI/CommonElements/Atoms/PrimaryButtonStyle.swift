import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Fonts.body.weight(.semibold))
            .foregroundStyle(DesignSystem.Colors.onPrimary)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, DesignSystem.Spacing.medium)
            .padding(.vertical, DesignSystem.Spacing.medium)
            .background(DesignSystem.Colors.primary)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.small))
            .opacity(configuration.isPressed ? DesignSystem.Opacity.pressedFilled : DesignSystem.Opacity.full)
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle { PrimaryButtonStyle() }
}

#Preview("Primary Button") {
    Button("Primary") {}
        .buttonStyle(.primary)
        .padding(.horizontal, DesignSystem.Spacing.medium)
        .frame(maxWidth: .infinity)
}

#Preview("Primary Button – Dark") {
    Button("Primary") {}
        .buttonStyle(.primary)
        .padding(.horizontal, DesignSystem.Spacing.medium)
        .frame(maxWidth: .infinity)
        .preferredColorScheme(.dark)
}
