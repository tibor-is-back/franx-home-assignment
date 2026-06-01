import Foundation

protocol Endpoint {
    nonisolated var urlRequest: URLRequest { get }
}
