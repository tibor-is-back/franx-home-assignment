import SwiftUI

@main
struct PlacesApp: App {
    var body: some Scene {
        WindowGroup {
            PlacesView(
                viewModel: PlacesViewModel(
                    locationService: DefaultLocationsService(
                        networkClient: URLSessionNetworkClient()
                    ),
                    deepLinkOpener: DefaultDeepLinkOpener()
                )
            )
        }
    }
}
