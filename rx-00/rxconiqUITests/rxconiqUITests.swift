//
//  rxconiqUITests.swift
//  rxconiqUITests
//
//  Created by Boska on 2019/1/17.
//  Copyright © 2019 boska. All rights reserved.
//

import XCTest

class rxconiqUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
      let app = XCUIApplication()
      app.launchArguments = ["testMode"]

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
      app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
      let app = XCUIApplication()
      app.tables.staticTexts["Transaction 10"].tap()
      XCTAssert(app.sheets["Transaction 10 € 38,46 \n 16-02-18 4:08"].exists)

      app.sheets["Transaction 10 € 38,46 \n 16-02-18 4:08"].buttons["Cancel"].tap()
      XCTAssertFalse(app.sheets["Transaction 10 € 38,46 \n 16-02-18 4:08"].exists)

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
