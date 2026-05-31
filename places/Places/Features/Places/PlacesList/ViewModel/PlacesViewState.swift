struct PlacesViewState: Equatable {
    let content: PlacesContentState
    let overlay: PlacesOverlayState

    init(_ content: PlacesContentState, overlay: PlacesOverlayState = .none) {
        self.content = content
        self.overlay = overlay
    }
}

enum PlacesContentState: Equatable {
    case loading
    case loaded([PlaceViewData])
    case noPlaces
    case error(title: String, subtitle: String)
}

enum PlacesOverlayState: Equatable {
    case toast(message: String)
    case none
}
