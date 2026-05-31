import Foundation

protocol LocationsService {
    func fetchLocations() async throws(LocationsServiceError) -> [LocationDTO]
}

nonisolated final class DefaultLocationsService: LocationsService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func fetchLocations() async throws(LocationsServiceError) -> [LocationDTO] {
        do {
            let response: LocationResponse = try await networkClient.fetch(LocationEndpoint.locations.urlRequest)
            return response.locations
        } catch {
            throw mapNetworkError(error)
        }
    }

    private func mapNetworkError(_ error: NetworkError) -> LocationsServiceError {
        switch error {
        case .transportError(let urlError):
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost, .timedOut:
                return .offline
            default:
                return .serverError
            }
        case .invalidResponse, .httpError:
            return .serverError
        case .decodingError:
            return .invalidData
        }
    }
}
