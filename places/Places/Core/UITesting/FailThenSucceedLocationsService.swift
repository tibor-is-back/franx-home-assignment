import Foundation

final class FailThenSucceedLocationsService: LocationsService {
    private var fetchCount = 0
    private let error: LocationsServiceError
    private let locations: [LocationDTO]

    init(
        error: LocationsServiceError = .serverError,
        locations: [LocationDTO] = UITestFixtures.sampleLocations
    ) {
        self.error = error
        self.locations = locations
    }

    func fetchLocations() async throws(LocationsServiceError) -> [LocationDTO] {
        fetchCount += 1
        if fetchCount == 1 {
            throw error
        }
        return locations
    }
}
