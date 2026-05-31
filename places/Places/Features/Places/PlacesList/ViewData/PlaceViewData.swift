struct PlaceViewData: Equatable {
    let locationName: String
    let latitude: String
    let longitude: String
    let continent: Continent

    var coordinatesLabel: String { "\(latitude), \(longitude)" }
}
