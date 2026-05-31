import SwiftUI

struct PlacesListView: View {
    let places: [PlaceViewData]
    let onPlaceTap: (PlaceViewData) -> Void

    var body: some View {
        VStack(spacing: 0) {
            ForEach(places.indices, id: \.self) { index in
                let place = places[index]
                Button {
                    onPlaceTap(place)
                } label: {
                    PlacesListItemView(place: place)
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier(AccessibilityIdentifier.Places.listItem(id: place.id))
                .accessibilityLabel("\(place.locationName), \(place.coordinatesLabel)")

                if index < places.count - 1 {
                    Divider()
                        .padding(.leading, listDividerLeadingInset)
                }
            }
        }
        .background(DesignSystem.Colors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.large))
    }

    private var listDividerLeadingInset: CGFloat {
        DesignSystem.Size.iconContainer
            + DesignSystem.Spacing.medium
            + DesignSystem.Spacing.medium
    }
}

#Preview("Places list") {
    PlacesListView(places: PreviewData.Places.places) { _ in }
        .padding(DesignSystem.Spacing.medium)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(DesignSystem.Colors.screenBackground)
}

#Preview("Places list – Dark") {
    PlacesListView(places: PreviewData.Places.places) { _ in }
        .padding(DesignSystem.Spacing.medium)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(DesignSystem.Colors.screenBackground)
        .preferredColorScheme(.dark)
}
