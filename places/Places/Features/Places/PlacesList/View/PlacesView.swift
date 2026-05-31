import SwiftUI

struct PlacesView: View {
    @State private var viewModel: PlacesViewModel

    init(viewModel: PlacesViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(DesignSystem.Colors.screenBackground)

                if case .toast(let message) = viewModel.state.overlay {
                    ToastView(message: message) {
                        Task { await dismissToast() }
                    }
                    .task(id: message) {
                        try? await Task.sleep(for: DesignSystem.Toast.dismissDelay)
                        await dismissToast()
                    }
                }
            }
            .navigationTitle("Places")
            .navigationBarTitleDisplayMode(.large)
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
        case .loaded(let places):
            ScrollView {
                PlacesListView(places: places) { place in
                    Task { await viewModel.handleEvent(.placeTapped(place)) }
                }
                .padding(DesignSystem.Spacing.medium)
            }
        case .noPlaces:
            ContentUnavailableView(
                Constants.Places.Strings.noLocationsTitle,
                systemImage: "mappin.slash",
                description: Text(Constants.Places.Strings.noLocationsDescription)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        }
    }

    private func dismissToast() async {
        await viewModel.handleEvent(.dismissToast)
    }
}

#Preview("Loaded") {
    PlacesView(viewModel: PreviewData.Places.loadedViewModel)
}

#Preview("Loading") {
    PlacesView(viewModel: PreviewData.Places.loadingViewModel)
}

#Preview("Error") {
    PlacesView(viewModel: PreviewData.Places.errorViewModel)
}

#Preview("No places") {
    PlacesView(viewModel: PreviewData.Places.noPlacesViewModel)
}
