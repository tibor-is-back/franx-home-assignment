import XCTest

final class ManualPlaceViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func test_givenManualPlace_whenCoordinatesIncomplete_thenOpenWikipediaIsDisabled() throws {
        // Given
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .loaded)

        app.tapElement(withIdentifier: UITestAccessibility.Places.manualPlaceButton)
        app.waitForExistence(ofIdentifier: UITestAccessibility.ManualPlace.latitudeField)

        let openButton = app.buttons[UITestAccessibility.ManualPlace.openWikipediaButton]

        // When
        // Then
        XCTAssertFalse(openButton.isEnabled)

        // When
        app.textFields[UITestAccessibility.ManualPlace.latitudeField].clearAndEnterText("52.37")

        // Then
        XCTAssertFalse(openButton.isEnabled)

        // When
        app.textFields[UITestAccessibility.ManualPlace.longitudeField].clearAndEnterText("4.89")

        // Then
        XCTAssertTrue(openButton.isEnabled)
    }

    @MainActor
    func test_givenManualPlace_whenOpenTappedAndDeepLinkFails_thenShowsToast() throws {
        // Given
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .loaded, deepLinkFails: true)

        app.tapElement(withIdentifier: UITestAccessibility.Places.manualPlaceButton)
        app.waitForExistence(ofIdentifier: UITestAccessibility.ManualPlace.latitudeField)

        app.textFields[UITestAccessibility.ManualPlace.latitudeField].clearAndEnterText("52.37")
        app.textFields[UITestAccessibility.ManualPlace.longitudeField].clearAndEnterText("4.89")

        // When
        app.buttons[UITestAccessibility.ManualPlace.openWikipediaButton].tap()

        // Then
        app.waitForExistence(ofIdentifier: UITestAccessibility.Common.toast)
    }

    @MainActor
    func test_givenToastVisible_whenDismissTapped_thenToastIsHidden() throws {
        // Given
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .loaded, deepLinkFails: true)

        app.tapElement(withIdentifier: UITestAccessibility.Places.manualPlaceButton)
        app.waitForExistence(ofIdentifier: UITestAccessibility.ManualPlace.latitudeField)

        app.textFields[UITestAccessibility.ManualPlace.latitudeField].clearAndEnterText("52.37")
        app.textFields[UITestAccessibility.ManualPlace.longitudeField].clearAndEnterText("4.89")
        app.buttons[UITestAccessibility.ManualPlace.openWikipediaButton].tap()

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
