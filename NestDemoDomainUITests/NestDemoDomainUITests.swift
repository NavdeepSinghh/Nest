//
//  NestDemoDomainUITests.swift
//  NestDemoDomainUITests
//
//  Created by Navdeep  Singh on 5/30/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import XCTest

class NestDemoDomainUITests: XCTestCase {
    
    var app : XCUIApplication!
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }    
    
   // Basic tests to see if Menu buttons available on the MenuBar
    func testCanNavigateToBuyScreen(){
        let collectionViewsQuery = XCUIApplication().collectionViews
        
        let buyStaticText = collectionViewsQuery.staticTexts["Buy"]
        XCTAssertTrue(buyStaticText.exists, "Buy button should be present")
        buyStaticText.tap()
        
        let rentStaticText = collectionViewsQuery.staticTexts["Rent"]
        XCTAssertTrue(buyStaticText.exists, "Rent button should be present")
        rentStaticText.tap()
    }
    
}
