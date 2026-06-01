import Foundation

nonisolated final class FailThenSucceedLocationsService: LocationsService, @unchecked Sendable {
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

    @concurrent
    func fetchLocations() async throws(LocationsServiceError) -> [LocationDTO] {
        fetchCount += 1
        if fetchCount == 1 {
            throw error
        }
        return locations
    }
}
