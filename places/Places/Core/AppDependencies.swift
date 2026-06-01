import Foundation

enum AppDependencies {
    static func makeLocationsService() -> LocationsService {
        if let configuration = UITestLaunchConfiguration.current {
            return configuration.locationsService
        }

        return DefaultLocationsService(networkClient: URLSessionNetworkClient())
    }

    static func makeDeepLinkOpener() -> DeepLinkOpener {
        if let configuration = UITestLaunchConfiguration.current {
            return configuration.deepLinkOpener
        }

        return DefaultDeepLinkOpener()
    }
}
