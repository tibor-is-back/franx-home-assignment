import Foundation

extension PreviewData {

    enum Places {
        static let places: [PlaceViewData] = [
            PlaceViewData(
                locationName: "San Francisco",
                latitude: 37.7749,
                longitude: -122.4194,
                continent: .northAmerica
            ),
            PlaceViewData(
                locationName: "São Paulo",
                latitude: -23.5505,
                longitude: -46.6333,
                continent: .southAmerica
            ),
            PlaceViewData(
                locationName: "London Eye",
                latitude: 51.5033,
                longitude: -0.1195,
                continent: .europe
            ),
            PlaceViewData(
                locationName: "Lagos",
                latitude: 6.5244,
                longitude: 3.3792,
                continent: .africa
            ),
            PlaceViewData(
                locationName: "Tokyo Tower",
                latitude: 35.6586,
                longitude: 139.7454,
                continent: .asia
            )
        ]

        static let deepLinkOpener: DeepLinkOpener = StubDeepLinkOpener()

        static let loadingLocationService: LocationsService = StubLocationsService(behavior: .loading)
        static let loadedLocationService: LocationsService = StubLocationsService(
            behavior: .success(UITestFixtures.sampleLocations)
        )
        static let noPlacesLocationService: LocationsService = StubLocationsService(behavior: .success([]))
        static let errorLocationService: LocationsService = StubLocationsService(
            behavior: .failure(.serverError)
        )
    }
}
