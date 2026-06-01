struct PlaceViewData: Equatable {
    let locationName: String
    let latitude: Double
    let longitude: Double
    let continent: Continent

    var id: String { "\(locationName)-\(latitude)-\(longitude)" }
    var coordinatesLabel: String { "\(latitude), \(longitude)" }
}
