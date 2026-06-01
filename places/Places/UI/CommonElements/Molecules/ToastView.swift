import SwiftUI

struct ToastView: View {
    let message: String
    let onDismiss: () -> Void

    @State private var opacity: Double = 0

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

            Button(action: dismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: DesignSystem.Size.chevronSize, weight: .semibold))
                    .foregroundStyle(DesignSystem.Colors.error.opacity(DesignSystem.Opacity.pressedPlain))
                    .frame(width: DesignSystem.Size.icon, height: DesignSystem.Size.icon)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Dismiss")
            .accessibilityIdentifier(AccessibilityIdentifier.Common.toastDismiss)
        }
        .frame(maxWidth: .infinity)
        .padding(DesignSystem.Spacing.medium)
        .accessibilityIdentifier(AccessibilityIdentifier.Common.toast)
        .background(DesignSystem.Colors.error.opacity(DesignSystem.Opacity.iconBackground))
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.medium))
        .overlay {
            RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.medium)
                .strokeBorder(DesignSystem.Colors.error, lineWidth: 1)
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(DesignSystem.Toast.fadeAnimation) {
                opacity = 1
            }
        }
        .task(id: message) {
            try? await Task.sleep(for: DesignSystem.Toast.dismissDelay)
            guard !Task.isCancelled else { return }
            dismiss()
        }
    }

    private func dismiss() {
        withAnimation(DesignSystem.Toast.fadeAnimation) {
            opacity = 0
        } completion: {
            onDismiss()
        }
    }
}

#Preview {
    ToastView(message: "Wikipedia app not installed") {}
        .padding(.horizontal, DesignSystem.Spacing.medium)
        .padding(.bottom, DesignSystem.Spacing.medium)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(DesignSystem.Colors.screenBackground)
}
