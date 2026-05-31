import SwiftUI

struct ErrorView: View {
    let title: String
    let subtitle: String?

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
        }
    }
}

#Preview("Light") {
    VStack {
        ErrorView(title: "Test Error", subtitle: "")
        ErrorView(title: "Test Error", subtitle: "There was a problem.")
    }
}

#Preview("Dark") {
    VStack {
        ErrorView(title: "Test Error", subtitle: "")
        ErrorView(title: "Test Error", subtitle: "There was a problem.")
    }
    .preferredColorScheme(.dark)
}
