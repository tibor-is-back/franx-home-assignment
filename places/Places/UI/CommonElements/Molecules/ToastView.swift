import SwiftUI

struct ToastView: View {
    let message: String
    let onDismiss: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: DesignSystem.Spacing.small) {
            Image(systemName: "nosign")
                .font(.system(size: DesignSystem.Size.icon))
                .foregroundStyle(DesignSystem.Colors.error)
                .accessibilityHidden(true)

            Text(message)
                .font(DesignSystem.Fonts.subheadline)
                .foregroundStyle(DesignSystem.Colors.error)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .accessibilityIdentifier(AccessibilityIdentifier.Common.toastMessage)
                .accessibilityLabel(message)

            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: DesignSystem.Size.chevronSize, weight: .semibold))
                    .foregroundStyle(DesignSystem.Colors.error.opacity(DesignSystem.Opacity.pressedPlain))
                    .frame(width: DesignSystem.Size.icon, height: DesignSystem.Size.icon)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Dismiss")
            .accessibilityIdentifier(AccessibilityIdentifier.Common.toastDismiss)
        }
        .padding(DesignSystem.Spacing.medium)
        .accessibilityIdentifier(AccessibilityIdentifier.Common.toast)
        .background(DesignSystem.Colors.error.opacity(DesignSystem.Opacity.iconBackground))
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.medium))
        .overlay {
            RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.medium)
                .strokeBorder(DesignSystem.Colors.error, lineWidth: 1)
        }
        .padding(.horizontal, DesignSystem.Spacing.medium)
        .padding(.bottom, DesignSystem.Spacing.medium)
    }
}

#Preview {
    ToastView(message: "Wikipedia app not installed") {}
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(DesignSystem.Colors.screenBackground)
}
