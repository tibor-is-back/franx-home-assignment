import XCTest

final class PlacesAccessibilityUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func test_givenLoadedPlacesList_whenViewAppeared_thenPassesAccessibilityAudit() throws {
        // Given
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .loaded)

        app.waitForExistence(ofIdentifier: UITestAccessibility.Places.sanFranciscoListItem)

        // Then
        try app.performAccessibilityAudit()
    }

    @MainActor
    func test_givenEmptyState_whenViewAppeared_thenPassesAccessibilityAudit() throws {
        // Given
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .empty)

        app.waitForExistence(ofIdentifier: UITestAccessibility.Places.empty)

        // Then
        try app.performAccessibilityAudit()
    }

    @MainActor
    func test_givenErrorState_whenViewAppeared_thenPassesAccessibilityAudit() throws {
        // Given
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .error)

        app.waitForExistence(ofIdentifier: UITestAccessibility.Common.errorRetry)

        // Then
        try app.performAccessibilityAudit()
    }

    @MainActor
    func test_givenManualPlaceSheet_whenPresented_thenPassesAccessibilityAudit() throws {
        // Given
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .loaded)

        app.tapElement(withIdentifier: UITestAccessibility.Places.manualPlaceButton)
        app.waitForExistence(ofIdentifier: UITestAccessibility.ManualPlace.latitudeField)

        // Then
        try app.performAccessibilityAudit()
    }
}
