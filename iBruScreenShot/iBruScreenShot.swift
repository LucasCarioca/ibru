//
//  iBruScreenShot.swift
//  iBruScreenShot
//
//  Created by Lucas Desouza on 9/13/21.
//

import XCTest

class iBruScreenShot: XCTestCase {
    let app: XCUIApplication = XCUIApplication()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupSnapshot(app)
        app.launchArguments = ["-test-data"]
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    

    func testTakeScreenShots() throws {
        
        snapshot("00menu")
        let tablesQuery = app.tables
        app.tables.buttons["Dashboard"].tap()
        snapshot("01dashboard")
        app.navigationBars["Dashboard"].buttons["Menu"].tap()
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            app.navigationBars["Dashboard"].buttons["Menu"].tap()
//        }
        
        
        app.tables/*@START_MENU_TOKEN@*/.buttons["Collection"]/*[[".cells[\"Collection\"].buttons[\"Collection\"]",".buttons[\"Collection\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("02collection")
        
        app.navigationBars["Collection"].buttons["Menu"].tap()


        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Brew List"]/*[[".cells[\"Brew List\"].buttons[\"Brew List\"]",".buttons[\"Brew List\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("02list")
        app.tables/*@START_MENU_TOKEN@*/.buttons["Red Wine, 1/30/21"]/*[[".cells[\"Red Wine, 1\/30\/21\"].buttons[\"Red Wine, 1\/30\/21\"]",".buttons[\"Red Wine, 1\/30\/21\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("03brewdetail")
        app.navigationBars["Red Wine"].buttons["Brews"].tap()
        app.buttons["carboy"].tap()
        snapshot("04newbrew")
        app.navigationBars["New brew"].buttons["Brews"].tap()
        app.navigationBars["Brews"].buttons["Menu"].tap()
        
        tablesQuery.buttons["Calculators"].tap()
        snapshot("05calculators")
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Alcohol by volume"]/*[[".cells[\"Alcohol by volume\"].buttons[\"Alcohol by volume\"]",".buttons[\"Alcohol by volume\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("06abv")
        app.navigationBars["ABV Calculator"].buttons["Calculators"].tap()
        tablesQuery.buttons["Gravity Estimator"].tap()
        snapshot("07gravityest")
        app.navigationBars["Gravity Estimator"].buttons["Calculators"].tap()
        app.navigationBars["Calculators"].buttons["Menu"].tap()
                                
    }
}
