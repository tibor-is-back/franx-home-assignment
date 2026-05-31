import SwiftUI

enum PlacesViewEvent {
    case viewAppeared
    case retryTapped
    case placeTapped(PlaceViewData)
    case dismissToast
}

@Observable
class PlacesViewModel {

    private let locationService: LocationsService
    private let deepLinkOpener: DeepLinkOpener

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

    }

    private func handlePlacesTap(for place: PlaceViewData) {
        do {
            try deepLinkOpener.openLocation(latitude: place.latitude, longitude: place.longitude)
        } catch {
            state = PlacesViewState(state.content, overlay: .toast(message: Constants.Places.Strings.appNotInstalled))
        }
    }
}
