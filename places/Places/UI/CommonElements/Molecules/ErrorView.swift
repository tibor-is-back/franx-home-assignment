import SwiftUI

struct ErrorView: View {
    let title: String
    let subtitle: String?
    let retryTitle: String
    let onRetry: (() -> Void)?

    init(
        title: String,
        subtitle: String?,
        retryTitle: String = "Retry",
        onRetry: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.retryTitle = retryTitle
        self.onRetry = onRetry
    }

    var body: some View {
        VStack(spacing: DesignSystem.Spacing.medium) {
            Image(systemName: "exclamationmark.octagon")
                .resizable()
                .scaledToFit()
                .foregroundStyle(DesignSystem.Colors.secondaryText)
                .frame(width: DesignSystem.Size.image, height: DesignSystem.Size.image)
            Text(title)
                .font(DesignSystem.Fonts.headline)
                .foregroundStyle(DesignSystem.Colors.primaryText)
                .accessibilityLabel(title)
            if let subtitle {
                Text(subtitle)
                    .font(DesignSystem.Fonts.subheadline)
                    .foregroundStyle(DesignSystem.Colors.secondaryText)
                    .accessibilityLabel(subtitle)
            }
            if let onRetry {
                Button(retryTitle, action: onRetry)
                    .buttonStyle(.secondary)
                    .accessibilityIdentifier(AccessibilityIdentifier.Common.errorRetry)
            }
        }
        .accessibilityIdentifier(AccessibilityIdentifier.Common.error)
    }
}

#Preview("With retry") {
    ErrorView(title: "Test Error", subtitle: "There was a problem.", onRetry: {})
}

#Preview("Without retry") {
    ErrorView(title: "Test Error", subtitle: "There was a problem.")
}
