import SwiftUI

struct PlacesListItemView: View {
    let place: PlaceViewData

    var body: some View {
        HStack(spacing: DesignSystem.Spacing.medium) {
            PlaceIconView(continent: place.continent)

            VStack(alignment: .leading, spacing: DesignSystem.Spacing.xSmall) {
                Text(place.locationName)
                    .font(DesignSystem.Fonts.headline)
                    .foregroundStyle(DesignSystem.Colors.primaryText)
                    .lineLimit(1)

                Text(place.coordinatesLabel)
                    .font(DesignSystem.Fonts.subheadline)
                    .foregroundStyle(DesignSystem.Colors.secondaryText)
                    .lineLimit(1)
            }

            Spacer(minLength: DesignSystem.Spacing.small)

            Image(systemName: "chevron.right")
                .font(.system(size: DesignSystem.Size.chevronSize, weight: .semibold))
                .foregroundStyle(DesignSystem.Colors.tertiaryText)
                .accessibilityHidden(true)
        }
        .frame(height: DesignSystem.Size.rowHeight)
        .padding(.horizontal, DesignSystem.Spacing.medium)
        .contentShape(Rectangle())
    }
}

#Preview("Places list item") {
    PlacesListItemView(
        place: PreviewData.Places.places[0]
    )
    .background(DesignSystem.Colors.cardBackground)
}
