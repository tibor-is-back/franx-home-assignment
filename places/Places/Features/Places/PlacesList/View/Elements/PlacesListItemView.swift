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

                Text(place.coordinatesLabel)
                    .font(DesignSystem.Fonts.subheadline)
                    .foregroundStyle(DesignSystem.Colors.secondaryText)
            }

            Spacer(minLength: DesignSystem.Spacing.small)

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(DesignSystem.Colors.tertiaryText)
                .accessibilityHidden(true)
        }
        .frame(minHeight: DesignSystem.Size.rowHeight)
        .padding(.horizontal, DesignSystem.Spacing.medium)
        .padding(.vertical, DesignSystem.Spacing.small)
        .contentShape(Rectangle())
    }
}

#Preview("Places list item") {
    PlacesListItemView(
        place: PreviewData.Places.places[0]
    )
    .background(DesignSystem.Colors.cardBackground)
}
