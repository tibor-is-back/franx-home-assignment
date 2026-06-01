import XCTest

extension XCUIElement {
    func clearAndEnterText(_ text: String) {
        tap()
        guard let currentValue = value as? String else {
            typeText(text)
            return
        }
        let deleteString = String(
            repeating: XCUIKeyboardKey.delete.rawValue,
            count: currentValue.count
        )
        typeText(deleteString + text)
    }
}

extension XCUIApplication {
    func element(withIdentifier identifier: String) -> XCUIElement {
        descendants(matching: .any).matching(identifier: identifier).firstMatch
    }

    func tapElement(
        withIdentifier identifier: String,
        timeout: TimeInterval = 5,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let button = buttons.matching(identifier: identifier).firstMatch
        if button.waitForExistence(timeout: timeout) {
            button.tap()
            return
        }

        let element = element(withIdentifier: identifier)
        waitForExistence(of: element, timeout: timeout, file: file, line: line)
        element.tap()
    }

    func waitForPlacesToLoad(
        timeout: TimeInterval = 5,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        waitForExistence(
            ofIdentifier: UITestAccessibility.Places.sanFranciscoListItem,
            timeout: timeout,
            file: file,
            line: line
        )
    }

    func waitForExistence(
        ofIdentifier identifier: String,
        timeout: TimeInterval = 5,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        waitForExistence(
            of: element(withIdentifier: identifier),
            timeout: timeout,
            file: file,
            line: line
        )
    }

    func waitForExistence(
        of element: XCUIElement,
        timeout: TimeInterval = 5,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertTrue(
            element.waitForExistence(timeout: timeout),
            "Expected \(element) to exist",
            file: file,
            line: line
        )
    }

    func waitForNonExistence(
        of element: XCUIElement,
        timeout: TimeInterval = 5,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let predicate = NSPredicate(format: "exists == false")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)
        XCTAssertEqual(result, .completed, "Expected \(element) to disappear", file: file, line: line)
    }
}
