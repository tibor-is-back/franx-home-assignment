import XCTest

extension XCUIApplication {
    enum PlacesFetchMode {
        case loaded
        case empty
        case error
        case offline
        case loading
    }

    func launchForUITesting(
        placesFetch: PlacesFetchMode = .loaded,
        deepLinkFails: Bool = false
    ) {
        var arguments = [UITestLaunchArgument.uiTesting]

        switch placesFetch {
        case .loaded:
            break
        case .empty:
            arguments.append(UITestLaunchArgument.placesFetchEmpty)
        case .error:
            arguments.append(UITestLaunchArgument.placesFetchError)
        case .offline:
            arguments.append(UITestLaunchArgument.placesFetchOffline)
        case .loading:
            arguments.append(UITestLaunchArgument.placesFetchLoading)
        }

        if deepLinkFails {
            arguments.append(UITestLaunchArgument.deepLinkFails)
        }

        launchArguments = arguments
        launch()
    }
}

private enum UITestLaunchArgument {
    static let uiTesting = "-ui-testing"
    static let placesFetchEmpty = "-places-fetch-empty"
    static let placesFetchError = "-places-fetch-error"
    static let placesFetchOffline = "-places-fetch-offline"
    static let placesFetchLoading = "-places-fetch-loading"
    static let deepLinkFails = "-deep-link-fails"
}
