import XCTest

final class PlacesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLoadedState_showsPlacesList() throws {
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .loaded)

        XCTAssertTrue(app.otherElements["places_list"].waitForExistence(timeout: 5))
    }

    @MainActor
    func testEmptyState_showsEmptyContent() throws {
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .empty)

        XCTAssertTrue(app.otherElements["places_empty"].waitForExistence(timeout: 5))
    }

    @MainActor
    func testErrorState_showsErrorContent() throws {
        let app = XCUIApplication()
        app.launchForUITesting(placesFetch: .error)

        XCTAssertTrue(app.otherElements["places_error"].waitForExistence(timeout: 5))
    }
}
