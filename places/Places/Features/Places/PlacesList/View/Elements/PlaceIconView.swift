import SwiftUI

struct PlaceIconView: View {
    let continent: Continent

    var body: some View {
        Image(continent.imageName)
            .resizable()
            .scaledToFit()
            .foregroundStyle(continent.color)
            .padding(DesignSystem.Spacing.small)
            .frame(
                width: DesignSystem.Size.iconContainer,
                height: DesignSystem.Size.iconContainer
            )
            .background(continent.color.opacity(DesignSystem.Opacity.iconBackground))
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.medium))
            .accessibilityHidden(true)
    }
}

#Preview("Place icons") {
    VStack(spacing: DesignSystem.Spacing.medium) {
        ForEach(Continent.allCases, id: \.self) { continent in
            PlaceIconView(continent: continent)
        }
    }
    .padding(DesignSystem.Spacing.large)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(DesignSystem.Colors.screenBackground)
}

#Preview("Place icons – Dark") {
    VStack(spacing: DesignSystem.Spacing.medium) {
        ForEach(Continent.allCases, id: \.self) { continent in
            PlaceIconView(continent: continent)
        }
    }
    .padding(DesignSystem.Spacing.large)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(DesignSystem.Colors.screenBackground)
    .preferredColorScheme(.dark)
}
