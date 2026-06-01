import SwiftUI

@Observable
class PlacesViewModel {

    private let locationService: LocationsService
    private let deepLinkOpener: DeepLinkOpener
    private var isFetching = false

    var state: PlacesViewState

    init(locationService: LocationsService, deepLinkOpener: DeepLinkOpener) {
        self.locationService = locationService
        self.deepLinkOpener = deepLinkOpener
        self.state = PlacesViewState(.loading)
    }

    func handleEvent(_ event: PlacesViewEvent) async {
        switch event {
        case .viewAppeared:
            await fetchLocations()
        case .retryTapped:
            await fetchLocations()
        case .placeTapped(let place):
            handlePlacesTap(for: place)
        case .dismissToast:
            state = PlacesViewState(state.content, overlay: PlacesOverlayState.none)
        }
    }

    private func fetchLocations() async {
        guard !isFetching else { return }
        isFetching = true
        defer { isFetching = false }

        state = PlacesViewState(.loading)

        do {
            let locations = try await locationService.fetchLocations()
            if locations.isEmpty {
                state = PlacesViewState(.noPlaces)
            } else {
                state = PlacesViewState(.loaded(processPlaces(locations)))
            }
        } catch {
            switch error {
            case .serverError, .invalidData:
                state = PlacesViewState(.error(title: Constants.Places.Strings.generalErrorTitle,
                                               subtitle: Constants.Places.Strings.generalErrorSubtitle))
            case .offline:
                state = PlacesViewState(.error(title: Constants.Places.Strings.noInternetErrorTitle,
                                               subtitle: Constants.Places.Strings.noInternetErrorSubtitle))
            }
        }
    }

    private func processPlaces(_ places: [LocationDTO]) -> [PlaceViewData] {
        places.map {
            PlaceViewData(
                locationName: $0.name ?? Constants.Places.Strings.unknownLocation,
                latitude: $0.lat,
                longitude: $0.long,
                continent: Continent.from(latitude: $0.lat, longitude: $0.long)
            )
        }
    }

    private func handlePlacesTap(for place: PlaceViewData) {
        do {
            try deepLinkOpener.openLocation(latitude: place.latitude, longitude: place.longitude)
        } catch {
            state = PlacesViewState(state.content, overlay: .toast(message: Constants.Places.Strings.appNotInstalled))
        }
    }
}
