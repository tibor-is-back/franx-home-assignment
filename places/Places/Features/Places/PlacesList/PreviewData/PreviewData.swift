import Foundation

enum PreviewData { }

extension PreviewData {

    enum Places {
        static let places: [PlaceViewData] = [
            PlaceViewData(
                locationName: "San Francisco",
                latitude: "37.7749",
                longitude: "-122.4194",
                continent: .northAmerica
            ),
            PlaceViewData(
                locationName: "São Paulo",
                latitude: "-23.5505",
                longitude: "-46.6333",
                continent: .southAmerica
            ),
            PlaceViewData(
                locationName: "London Eye",
                latitude: "51.5033",
                longitude: "-0.1195",
                continent: .europe
            ),
            PlaceViewData(
                locationName: "Lagos",
                latitude: "6.5244",
                longitude: "3.3792",
                continent: .africa
            ),
            PlaceViewData(
                locationName: "Tokyo Tower",
                latitude: "35.6586",
                longitude: "139.7454",
                continent: .asia
            )
        ]

        static var loadingViewModel: PlacesViewModel {
            makeViewModel(state: .loading)
        }

        static var loadedViewModel: PlacesViewModel {
            makeViewModel(state: .loaded(places))
        }

        static var noPlacesViewModel: PlacesViewModel {
            makeViewModel(state: .noPlaces)
        }

        static var errorViewModel: PlacesViewModel {
            makeViewModel(state: .error(title: errorTitle, subtitle: errorSubtitle))
        }

        private static let errorTitle = "Couldn't load places"
        private static let errorSubtitle = "Check your connection and try again."

        private static func makeViewModel(state: PlacesContentState) -> PlacesViewModel {
            let viewModel = PlacesViewModel(
                locationService: MockLocationsService(),
                deepLinkOpener: MockDeepLinkOpener()
            )
            viewModel.state = PlacesViewState(state)
            return viewModel
        }
    }
}

private struct MockLocationsService: LocationsService {
    func fetchLocations() async throws(LocationsServiceError) -> [LocationDTO] {
        []
    }
}

private struct MockDeepLinkOpener: DeepLinkOpener {
    func openLocation(latitude: String, longitude: String) throws(DeepLinkOpenerError) {}
}
