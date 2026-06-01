import UIKit

enum DeepLinkOpenerError: Error, Sendable {
    case unableToOpenDestination
}

@MainActor
protocol DeepLinkOpener: Sendable {
    func openLocation(latitude: Double, longitude: Double) throws(DeepLinkOpenerError)
}

@MainActor
final class DefaultDeepLinkOpener: DeepLinkOpener {

    func openLocation(latitude: Double, longitude: Double) throws(DeepLinkOpenerError) {
        var components = URLComponents()
        components.scheme = "wikipedia"
        components.host = "places"
        components.queryItems = [
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude))
        ]
        guard let url = components.url else {
            assertionFailure("Failed to construct deep link URL")
            return
        }

        guard UIApplication.shared.canOpenURL(url) else {
            throw .unableToOpenDestination
        }

        UIApplication.shared.open(url)
    }
}
