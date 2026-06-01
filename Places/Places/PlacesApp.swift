import SwiftUI

@main
struct PlacesApp: App {
    var body: some Scene {
        WindowGroup {
            PlacesView(
                locationService: AppDependencies.makeLocationsService(),
                deepLinkOpener: AppDependencies.makeDeepLinkOpener()
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
