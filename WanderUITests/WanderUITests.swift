import XCTest

final class WanderUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--reset"]
        app.launch()
    }

    func testHomeScreenLoads() {
        XCTAssertTrue(app.tabBars.buttons["Home"].exists)
        XCTAssertTrue(app.tabBars.buttons["Explore"].exists)
        XCTAssertTrue(app.tabBars.buttons["Journal"].exists)
        XCTAssertTrue(app.tabBars.buttons["Profile"].exists)
    }

    func testHomeTabShowsTitle() {
        XCTAssertTrue(app.staticTexts["Wander"].exists)
        XCTAssertTrue(app.staticTexts["Meet a stranger. They're not real."].exists)
    }

    func testMeetButtonExists() {
        XCTAssertTrue(app.buttons["Meet a New Stranger"].exists)
    }

    func testNavigationToExplore() {
        app.tabBars.buttons["Explore"].tap()
        XCTAssertTrue(app.staticTexts["Explore"].exists)
    }

    func testNavigationToJournal() {
        app.tabBars.buttons["Journal"].tap()
        XCTAssertTrue(app.staticTexts["Journal"].exists)
    }

    func testNavigationToProfile() {
        app.tabBars.buttons["Profile"].tap()
        XCTAssertTrue(app.staticTexts["Anonymous Wanderer"].exists)
    }

    func testNavigateToChat() {
        app.collectionViews.cells.firstMatch.tap()
        XCTAssertTrue(app.buttons["xmark"].exists)
    }
}