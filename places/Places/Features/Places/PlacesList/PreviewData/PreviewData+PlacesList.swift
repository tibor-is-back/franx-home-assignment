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

        static let deepLinkOpener: DeepLinkOpener = MockDeepLinkOpener()

        static let loadingLocationService: LocationsService = PreviewLocationsService(behavior: .loading)
        static let loadedLocationService: LocationsService = PreviewLocationsService(
            behavior: .success(previewLocations)
        )
        static let noPlacesLocationService: LocationsService = PreviewLocationsService(behavior: .success([]))
        static let errorLocationService: LocationsService = PreviewLocationsService(
            behavior: .failure(.serverError)
        )

        private static let previewLocations: [LocationDTO] = [
            LocationDTO(name: "San Francisco", lat: 37.7749, long: -122.4194),
            LocationDTO(name: "São Paulo", lat: -23.5505, long: -46.6333),
            LocationDTO(name: "London Eye", lat: 51.5033, long: -0.1195),
            LocationDTO(name: "Lagos", lat: 6.5244, long: 3.3792),
            LocationDTO(name: "Tokyo Tower", lat: 35.6586, long: 139.7454)
        ]
    }
}

private struct PreviewLocationsService: LocationsService {
    enum Behavior {
        case loading
        case success([LocationDTO])
        case failure(LocationsServiceError)
    }

    let behavior: Behavior

    func fetchLocations() async throws(LocationsServiceError) -> [LocationDTO] {
        switch behavior {
        case .loading:
            await withCheckedContinuation { (_: CheckedContinuation<Void, Never>) in }
            return []
        case .success(let locations):
            return locations
        case .failure(let error):
            throw error
        }
    }
}

private struct MockDeepLinkOpener: DeepLinkOpener {
    func openLocation(latitude: Double, longitude: Double) throws(DeepLinkOpenerError) {}
}
