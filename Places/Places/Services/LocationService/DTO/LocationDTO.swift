import Foundation

nonisolated struct LocationDTO: Decodable {
    let name: String?
    let lat: Double
    let long: Double
}
