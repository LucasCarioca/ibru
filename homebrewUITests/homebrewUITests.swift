//
//  homebrewUITests.swift
//  homebrewUITests
//
//  Created by Lucas Desouza on 1/26/21.
//

import XCTest

class baseTests: XCTestCase {
    let app: XCUIApplication = XCUIApplication()
    
    override func setUpWithError() throws {
        app.launchArguments = ["-test-data"]
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testBasicNavigation() throws {
        
        let dashboardNavigationBar = app.navigationBars["Dashboard"]
        XCTAssert(dashboardNavigationBar.staticTexts["Dashboard"].exists)
        dashboardNavigationBar.buttons["Menu"].tap()
        XCTAssert(app.navigationBars["Menu"].staticTexts["Menu"].exists)


        let tablesQuery = app.tables
        tablesQuery.buttons["Collection"].tap()
        XCTAssert(app.navigationBars["Collection"].staticTexts["Collection"].exists)
        tablesQuery.buttons["IPA Beer, Bottle Count: , 50, Age: , 2.5 Months"].tap()
        let beerIpaNavigationBar = app.navigationBars["IPA Beer"]
        XCTAssert(beerIpaNavigationBar.staticTexts["IPA Beer"].exists)
        XCTAssert(app.staticTexts["Primary Fermentation"].exists)
        XCTAssert(app.staticTexts["Bottled"].exists)
        beerIpaNavigationBar.buttons["Collection"].tap()
        app.navigationBars["Collection"].buttons["Menu"].tap()
        
        
        tablesQuery.cells["Brew List"].otherElements.containing(.button, identifier:"Brew List").element.tap()
        let brewsNavigationBar = app.navigationBars["Brews"]
        XCTAssert(brewsNavigationBar.staticTexts["Brews"].exists)
        brewsNavigationBar.buttons["Menu"].tap()
        
    
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Calculators"]/*[[".cells[\"Calculators\"].buttons[\"Calculators\"]",".buttons[\"Calculators\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.navigationBars["Calculators"].staticTexts["Calculators"].exists)
        tablesQuery.cells["Alcohol by volume"].otherElements.containing(.button, identifier:"Alcohol by volume").element.tap()
        let abvCalculatorNavigationBar = app.navigationBars["ABV Calculator"]
        XCTAssert(abvCalculatorNavigationBar.staticTexts["ABV Calculator"].exists)
        abvCalculatorNavigationBar.buttons["Calculators"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Gravity Estimator"]/*[[".cells[\"Gravity Estimator\"].buttons[\"Gravity Estimator\"]",".buttons[\"Gravity Estimator\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.navigationBars["Gravity Estimator"].staticTexts["Gravity Estimator"].exists)
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
