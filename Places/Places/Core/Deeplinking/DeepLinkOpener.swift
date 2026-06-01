import UIKit

enum DeepLinkOpenerError: Error {
    case unableToOpenDestination
}

protocol DeepLinkOpener {
    func openLocation(latitude: Double, longitude: Double) throws(DeepLinkOpenerError)
}

final class DefaultDeepLinkOpener: DeepLinkOpener {

    func openLocation(latitude: Double, longitude: Double) throws(DeepLinkOpenerError) {
        let latitudeValue = String(latitude)
        let longitudeValue = String(longitude)

        guard let url = URL(
            string: "wikipedia://places?latitude=\(latitudeValue)&longitude=\(longitudeValue)"
        ) else {
            assertionFailure("Failed to construct deep link URL")
            return
        }

        guard UIApplication.shared.canOpenURL(url) else {
            throw .unableToOpenDestination
        }

        UIApplication.shared.open(url)
    }
}
