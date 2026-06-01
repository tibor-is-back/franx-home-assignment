import SwiftUI

@main
struct PlacesApp: App {
    private let deepLinkOpener = DefaultDeepLinkOpener()

    var body: some Scene {
        WindowGroup {
            PlacesView(
                locationService: DefaultLocationsService(
                    networkClient: URLSessionNetworkClient()
                ),
                deepLinkOpener: deepLinkOpener
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
