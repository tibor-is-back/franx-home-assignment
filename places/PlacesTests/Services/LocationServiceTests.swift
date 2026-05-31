import Foundation
import Testing
@testable import Places

struct LocationServiceTests {
    @Test
    func givenLocationResponse_whenFetchLocations_thenReturnsLocationsAndRequestsEndpoint() async throws {
        // Given
        let networkClient = MockNetworkClient()
        networkClient.response = LocationResponse(
            locations: [LocationDTO(name: "Amsterdam", lat: 52.3676, long: 4.9041)]
        )
        let sut = DefaultLocationsService(networkClient: networkClient)

        // When
        let result = try await sut.fetchLocations()

        // Then
        #expect(result.count == 1)
        #expect(result[0].name == "Amsterdam")
        #expect(result[0].lat == 52.3676)
        #expect(result[0].long == 4.9041)
        #expect(networkClient.lastRequest?.url?.absoluteString.contains("locations.json") == true)
    }

    @Test
    func givenNotConnectedToInternet_whenFetchLocations_thenThrowsOffline() async {
        // Given
        let networkClient = MockNetworkClient()
        networkClient.error = .transportError(URLError(.notConnectedToInternet))
        let sut = DefaultLocationsService(networkClient: networkClient)

        // Then
        await #expect(throws: LocationsServiceError.offline) {
            try await sut.fetchLocations()
        }
    }

    @Test
    func givenNetworkConnectionLost_whenFetchLocations_thenThrowsOffline() async {
        // Given
        let networkClient = MockNetworkClient()
        networkClient.error = .transportError(URLError(.networkConnectionLost))
        let sut = DefaultLocationsService(networkClient: networkClient)

        // When
        // Then
        await #expect(throws: LocationsServiceError.offline) {
            try await sut.fetchLocations()
        }
    }

    @Test
    func givenRequestTimedOut_whenFetchLocations_thenThrowsOffline() async {
        // Given
        let networkClient = MockNetworkClient()
        networkClient.error = .transportError(URLError(.timedOut))
        let sut = DefaultLocationsService(networkClient: networkClient)

        // When
        // Then
        await #expect(throws: LocationsServiceError.offline) {
            try await sut.fetchLocations()
        }
    }

    @Test
    func givenCancelledTransportError_whenFetchLocations_thenThrowsServerError() async {
        // Given
        let networkClient = MockNetworkClient()
        networkClient.error = .transportError(URLError(.cancelled))
        let sut = DefaultLocationsService(networkClient: networkClient)

        // When
        // Then
        await #expect(throws: LocationsServiceError.serverError) {
            try await sut.fetchLocations()
        }
    }

    @Test
    func givenInvalidResponse_whenFetchLocations_thenThrowsServerError() async {
        // Given
        let networkClient = MockNetworkClient()
        networkClient.error = .invalidResponse
        let sut = DefaultLocationsService(networkClient: networkClient)

        // When
        // Then
        await #expect(throws: LocationsServiceError.serverError) {
            try await sut.fetchLocations()
        }
    }

    @Test
    func givenHTTP500_whenFetchLocations_thenThrowsServerError() async {
        // Given
        let networkClient = MockNetworkClient()
        networkClient.error = .httpError(500)
        let sut = DefaultLocationsService(networkClient: networkClient)

        // When
        // Then
        await #expect(throws: LocationsServiceError.serverError) {
            try await sut.fetchLocations()
        }
    }

    @Test
    func givenDecodingError_whenFetchLocations_thenThrowsInvalidData() async {
        // Given
        let networkClient = MockNetworkClient()
        networkClient.error = .decodingError(URLError(.badURL))
        let sut = DefaultLocationsService(networkClient: networkClient)

        // When
        // Then
        await #expect(throws: LocationsServiceError.invalidData) {
            try await sut.fetchLocations()
        }
    }
}

private final class MockNetworkClient: NetworkClient {
    var response: LocationResponse?
    var error: NetworkError?
    private(set) var lastRequest: URLRequest?

    func fetch<T: Decodable>(_ request: URLRequest) async throws(NetworkError) -> T {
        lastRequest = request
        if let error {
            throw error
        }
        guard let response = response as? T else {
            throw NetworkError.decodingError(URLError(.cannotDecodeContentData))
        }
        return response
    }
}
