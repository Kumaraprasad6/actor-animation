import XCTest

final class ActorAnimationUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testGalleryAppearsWithPatterns() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.navigationBars["Animations"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Scale Pulse"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Marquee"].exists)
    }

    @MainActor
    func testSearchFiltersPatterns() throws {
        let app = XCUIApplication()
        app.launch()

        let searchField = app.textFields["Search patterns"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        searchField.tap()
        searchField.typeText("card")

        XCTAssertTrue(app.staticTexts["Flip Card"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.staticTexts["Scale Pulse"].exists)
    }

    @MainActor
    func testNavigateToPatternDetail() throws {
        let app = XCUIApplication()
        app.launch()

        let scalePulseCard = app.staticTexts["Scale Pulse"]
        XCTAssertTrue(scalePulseCard.waitForExistence(timeout: 5))
        scalePulseCard.tap()

        XCTAssertTrue(app.navigationBars["Scale Pulse"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["Tap to Trigger"].waitForExistence(timeout: 3))
    }

    @MainActor
    func testCategoryChipFilters() throws {
        let app = XCUIApplication()
        app.launch()

        let shapeChip = app.buttons["Shape"]
        XCTAssertTrue(shapeChip.waitForExistence(timeout: 5))
        shapeChip.tap()

        XCTAssertTrue(app.staticTexts["Progress Arc"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts["Morphing Shape"].exists)
    }

    @MainActor
    func testResetButtonInDetail() throws {
        let app = XCUIApplication()
        app.launch()

        app.staticTexts["Rotate"].tap()
        XCTAssertTrue(app.navigationBars["Rotate"].waitForExistence(timeout: 5))

        let resetButton = app.buttons["arrow.counterclockwise"]
        XCTAssertTrue(resetButton.exists)
        resetButton.tap()
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}