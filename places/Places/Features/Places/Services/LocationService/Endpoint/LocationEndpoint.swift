import Foundation

 enum LocationEndpoint: Endpoint {
    case locations

     var urlRequest: URLRequest {
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
