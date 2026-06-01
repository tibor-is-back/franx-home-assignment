import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Fonts.body.weight(.semibold))
            .foregroundStyle(isEnabled ? DesignSystem.Colors.onPrimary : Color(.secondaryLabel))
            .frame(maxWidth: .infinity)
            .padding(.horizontal, DesignSystem.Spacing.medium)
            .padding(.vertical, DesignSystem.Spacing.medium)
            .background(isEnabled ? DesignSystem.Colors.primary : Color(.systemGray4))
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.small))
            .opacity(isEnabled && configuration.isPressed ? DesignSystem.Opacity.pressedFilled : DesignSystem.Opacity.full)
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

#Preview("Primary Button – Disabled") {
    Button("Primary") {}
        .buttonStyle(.primary)
        .disabled(true)
        .padding(.horizontal, DesignSystem.Spacing.medium)
        .frame(maxWidth: .infinity)
}
