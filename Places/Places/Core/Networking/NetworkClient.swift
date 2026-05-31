import Foundation

protocol NetworkClient {
    func fetch<T: Decodable>(_ request: URLRequest) async throws(NetworkError) -> T
}

final class URLSessionNetworkClient: NetworkClient {
    func fetch<T: Decodable>(_ request: URLRequest) async throws(NetworkError) -> T {
        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await URLSession.shared.data(for: request)
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
