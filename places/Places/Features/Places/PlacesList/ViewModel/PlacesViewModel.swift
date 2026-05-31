import SwiftUI

enum PlacesViewState {
    case loading
    case loadedPlaces(places: [PlaceViewData])
    case noPlaces
    case error(title: String, subtitle: String?)
}

enum PlacesViewEvent {
    case viewAppeared
    case retryTapped
    case placeTapped(PlaceViewData)
}

@Observable
class PlacesViewModel {
    
    private let locationService: LocationsService
    
    var state: PlacesViewState = .loading
    
    init(locationService: LocationsService) {
        self.locationService = locationService
        self.state = state
    }
    
    func handleEvent(_ event: PlacesViewEvent) async {
        switch event {
        case .viewAppeared:
            await fetchLocations()
        case .retryTapped:
            await fetchLocations()
        case .placeTapped(let place):
            print("Whololo - Place tapped")
        }
    }
    
    private func fetchLocations() async {
        
    }
}

