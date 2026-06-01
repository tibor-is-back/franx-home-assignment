import SwiftUI

struct PlacesView: View {
    @State private var viewModel: PlacesViewModel
    @State private var isManualPlacePresented = false

    private let deepLinkOpener: DeepLinkOpener

    init(locationService: LocationsService, deepLinkOpener: DeepLinkOpener) {
        _viewModel = State(
            initialValue: PlacesViewModel(
                locationService: locationService,
                deepLinkOpener: deepLinkOpener
            )
        )
        self.deepLinkOpener = deepLinkOpener
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(DesignSystem.Colors.screenBackground)

                if case .toast(let message) = viewModel.state.overlay {
                    ToastView(message: message) {
                        Task { await viewModel.handleEvent(.dismissToast) }
                    }
                }
            }
            .navigationTitle(Constants.Places.Strings.title)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(Constants.Places.Strings.manualPlace) {
                        isManualPlacePresented = true
                    }
                    .accessibilityIdentifier(AccessibilityIdentifier.Places.manualPlaceButton)
                }
            }
            .accessibilityIdentifier(AccessibilityIdentifier.Places.root)
        }
        .sheet(isPresented: $isManualPlacePresented) {
            ManualPlaceView(deepLinkOpener: deepLinkOpener)
        }
        .task {
            await viewModel.handleEvent(.viewAppeared)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state.content {
        case .loading:
            LoadingView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .accessibilityIdentifier(AccessibilityIdentifier.Places.loading)
        case .loaded(let places):
            ScrollView {
                PlacesListView(places: places) { place in
                    Task { await viewModel.handleEvent(.placeTapped(place)) }
                }
                .padding(DesignSystem.Spacing.medium)
            }
            .accessibilityIdentifier(AccessibilityIdentifier.Places.list)
        case .noPlaces:
            ContentUnavailableView(
                Constants.Places.Strings.noLocationsTitle,
                systemImage: "mappin.slash",
                description: Text(Constants.Places.Strings.noLocationsDescription)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .accessibilityIdentifier(AccessibilityIdentifier.Places.empty)
        case .error(let title, let subtitle):
            ErrorView(
                title: title,
                subtitle: subtitle,
                retryTitle: Constants.Places.Strings.retry
            ) {
                Task {
                    await viewModel.handleEvent(.retryTapped)
                }
            }
            .padding(DesignSystem.Spacing.medium)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .accessibilityIdentifier(AccessibilityIdentifier.Places.error)
        }
    }

}

#Preview("Loaded") {
    PlacesView(
        locationService: PreviewData.Places.loadedLocationService,
        deepLinkOpener: PreviewData.Places.deepLinkOpener
    )
}

#Preview("Loading") {
    PlacesView(
        locationService: PreviewData.Places.loadingLocationService,
        deepLinkOpener: PreviewData.Places.deepLinkOpener
    )
}

#Preview("Error") {
    PlacesView(
        locationService: PreviewData.Places.errorLocationService,
        deepLinkOpener: PreviewData.Places.deepLinkOpener
    )
}

#Preview("No places") {
    PlacesView(
        locationService: PreviewData.Places.noPlacesLocationService,
        deepLinkOpener: PreviewData.Places.deepLinkOpener
    )
}
