import SwiftUI

struct LoadingView: View {
    let title: String

    init(title: String? = nil) {
        self.title = title ?? "Loading..."
    }

    var body: some View {
        VStack(spacing: DesignSystem.Spacing.medium) {
            ProgressView()
                .controlSize(.large)
                .tint(DesignSystem.Colors.primary)
            Text(title)
                .font(DesignSystem.Fonts.body)
                .foregroundStyle(DesignSystem.Colors.primaryText)
                .accessibilityLabel(title)
        }
        .accessibilityIdentifier(AccessibilityIdentifier.Common.loading)
    }
}

#Preview("Light") {
    LoadingView()
}

#Preview("Dark") {
    LoadingView()
        .preferredColorScheme(.dark)
}
