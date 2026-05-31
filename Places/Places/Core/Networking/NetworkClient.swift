import Foundation

protocol NetworkClient {
    func fetch<T: Decodable>(_ request: URLRequest) async throws(NetworkError) -> T
}

nonisolated final class URLSessionNetworkClient: NetworkClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(_ request: URLRequest) async throws(NetworkError) -> T {
        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: request)
        } catch let error as URLError {
            throw .transportError(error)
        } catch {
            throw .transportError(.init(.unknown))
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw .invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw .httpError(httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw .decodingError(error)
        }
    }
}
