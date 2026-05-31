import UIKit

enum DeepLinkOpenerError: Error {
    case unableToOpenDestination
}

protocol DeepLinkOpener {
    func openLocation(latitude: String, longitude: String) throws(DeepLinkOpenerError)
}

final class DefaultDeepLinkOpener: DeepLinkOpener {
    
    func openLocation(latitude: String, longitude: String) throws(DeepLinkOpenerError) {

        guard let url = URL(
            string: "wikipedia://places?lat=\(latitude)&lon=\(longitude)"
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
