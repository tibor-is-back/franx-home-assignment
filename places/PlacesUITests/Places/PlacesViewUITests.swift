import XCTest

final class PlacesViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func test_givenLoaded_whenPlaceTappedAndDeepLinkFails_thenShowsToast() throws {
        // Given
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .loaded, deepLinkFails: true)

        app.waitForExistence(ofIdentifier: UITestAccessibility.Places.sanFranciscoListItem)

        // When
        app.tapElement(withIdentifier: UITestAccessibility.Places.sanFranciscoListItem)

        // Then
        app.waitForExistence(ofIdentifier: UITestAccessibility.Common.toast)
    }

    @MainActor
    func test_givenEmptyLocations_whenViewAppeared_thenShowsEmptyState() throws {
        // Given
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .empty)

        // When
        // Then
        app.waitForExistence(ofIdentifier: UITestAccessibility.Places.empty)
    }

    @MainActor
    func test_givenFailingThenLoadedLocations_whenRetryTapped_thenShowsPlacesList() throws {
        // Given
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .errorThenLoaded)

        app.waitForExistence(ofIdentifier: UITestAccessibility.Common.errorRetry)

        // When
        app.tapElement(withIdentifier: UITestAccessibility.Common.errorRetry)

        // Then
        app.waitForExistence(ofIdentifier: UITestAccessibility.Places.sanFranciscoListItem)
    }

    @MainActor
    func test_givenLoaded_whenPlaceTappedAndToastDismissed_thenToastIsHidden() throws {
        // Given
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .loaded, deepLinkFails: true)

        app.waitForExistence(ofIdentifier: UITestAccessibility.Places.sanFranciscoListItem)
        app.tapElement(withIdentifier: UITestAccessibility.Places.sanFranciscoListItem)

        let toast = app.element(withIdentifier: UITestAccessibility.Common.toast)
        app.waitForExistence(of: toast)

        // When
        let dismissButton = app.buttons[UITestAccessibility.Common.toastDismiss]
        if dismissButton.exists {
            dismissButton.tap()
        }

        // Then
        app.waitForNonExistence(of: toast)
    }
}
