import Foundation

struct UITestLaunchConfiguration {
    enum PlacesFetchMode {
        case loaded
        case empty
        case error
        case offline
        case loading
    }

    let placesFetchMode: PlacesFetchMode
    let deepLinkShouldFail: Bool

    static var current: UITestLaunchConfiguration? {
        let arguments = ProcessInfo.processInfo.arguments
        guard arguments.contains(UITestLaunchArgument.uiTesting) else {
            return nil
        }

        return UITestLaunchConfiguration(
            placesFetchMode: placesFetchMode(from: arguments),
            deepLinkShouldFail: arguments.contains(UITestLaunchArgument.deepLinkFails)
        )
    }

    var locationsService: LocationsService {
        switch placesFetchMode {
        case .loaded:
            return StubLocationsService(behavior: .success(UITestFixtures.sampleLocations))
        case .empty:
            return StubLocationsService(behavior: .success([]))
        case .error:
            return StubLocationsService(behavior: .failure(.serverError))
        case .offline:
            return StubLocationsService(behavior: .failure(.offline))
        case .loading:
            return StubLocationsService(behavior: .loading)
        }
    }

    var deepLinkOpener: DeepLinkOpener {
        StubDeepLinkOpener(shouldFail: deepLinkShouldFail)
    }

    private static func placesFetchMode(from arguments: [String]) -> PlacesFetchMode {
        if arguments.contains(UITestLaunchArgument.placesFetchEmpty) {
            return .empty
        }
        if arguments.contains(UITestLaunchArgument.placesFetchError) {
            return .error
        }
        if arguments.contains(UITestLaunchArgument.placesFetchOffline) {
            return .offline
        }
        if arguments.contains(UITestLaunchArgument.placesFetchLoading) {
            return .loading
        }
        return .loaded
    }
}
