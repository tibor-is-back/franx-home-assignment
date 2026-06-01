import Foundation

struct StubDeepLinkOpener: DeepLinkOpener {
    var shouldFail = false

    func openLocation(latitude: Double, longitude: Double) throws(DeepLinkOpenerError) {
        if shouldFail {
            throw .unableToOpenDestination
        }
    }
}
