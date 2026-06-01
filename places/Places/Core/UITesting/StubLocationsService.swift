import Foundation

nonisolated struct StubLocationsService: LocationsService, Sendable {
    enum Behavior {
        case loading
        case success([LocationDTO])
        case failure(LocationsServiceError)
    }

    let behavior: Behavior

    @concurrent
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
