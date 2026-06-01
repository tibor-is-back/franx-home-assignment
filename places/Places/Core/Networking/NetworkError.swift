import Foundation

enum NetworkError: Error {
    case invalidResponse
    case httpError(Int)
    case decodingError(Error)
    case transportError(URLError)
}
