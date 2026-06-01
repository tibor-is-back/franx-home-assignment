import Foundation

nonisolated enum LocationEndpoint: Endpoint {
    case locations

    nonisolated var urlRequest: URLRequest {
        switch self {
        case .locations:
            URLRequest(
                url: URL(string:
                    "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json"
                )!
            )
        }
    }
}
