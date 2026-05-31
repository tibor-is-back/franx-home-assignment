import SwiftUI

enum DesignSystem {
    enum Colors {
        static let primary = Color.blue
        static let onPrimary = Color.white

        static let screenBackground = Color(.systemGroupedBackground)
        static let cardBackground = Color(.secondarySystemGroupedBackground)

        static let primaryText = Color.primary
        static let secondaryText = Color.secondary
        static let tertiaryText = Color(.tertiaryLabel)

        static let separator = Color(.separator)

        static let locationBlue = Color.blue
        static let locationPurple = Color.purple
        static let locationRed = Color.red
        static let locationOrange = Color.orange
        static let locationTeal = Color.teal
    }

    enum Spacing {
        static let xSmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }

    enum CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xLarge: CGFloat = 20
    }

    enum Size {
        static let icon: CGFloat = 24

        static let image: CGFloat = 64

        static let locationIconContainer: CGFloat = 40
        static let rowHeight: CGFloat = 72
        static let chevronSize: CGFloat = 14
    }

    enum Fonts {
        static let largeTitle = Font.largeTitle.weight(.bold)
        static let title = Font.title.weight(.semibold)
        static let headline = Font.headline
        static let body = Font.body
        static let subheadline = Font.subheadline
        static let caption = Font.caption
        static let footnote = Font.footnote
    }

    enum Opacity {
        static let full: Double = 1
        static let pressedFilled: Double = 0.85
        static let pressedPlain: Double = 0.6
    }
}
