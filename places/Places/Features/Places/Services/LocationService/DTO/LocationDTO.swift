import Foundation

nonisolated struct LocationDTO: Decodable, Sendable {
    let name: String?
    let lat: Double
    let long: Double
}
