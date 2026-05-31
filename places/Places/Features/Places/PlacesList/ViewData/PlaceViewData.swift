struct PlaceViewData: Identifiable, Equatable {
    let locationName: String
    let latitude: String
    let longitude: String
    let continent: Continent

    var id: String { "\(locationName)-\(latitude)-\(longitude)" }

    var coordinatesLabel: String { "\(latitude), \(longitude)" }
}
