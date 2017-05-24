//
//  NestDemoDomainMockTests.swift
//  NestDemoDomainMockTests
//
//  Created by Navdeep  Singh on 5/24/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import XCTest
@testable import NestDemoDomain

class NestDemoDomainMockTests: XCTestCase {
    var apiManagerUnderTest : APIManager!
    
    override func setUp() {
        super.setUp()
        apiManagerUnderTest = APIManager()
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "PropertiesAPIMock", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        //  session related information
        let url = URL (string: "https://mobile-adapter-api.domain.com.au/v1/search")
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        //  Create mock session using the above mentioned values
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
        
        apiManagerUnderTest.defaultSession = sessionMock

    }
    
    func testGetPropertiesResults() {
        // Given 
        let promise = expectation(description: "Status code : 200")
        
        // When
        XCTAssertEqual(apiManagerUnderTest.propertiesArray.count,0, "Empty properties array before the task begins")
        apiManagerUnderTest.getPropertyResults(for :""){_,_ in
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        // Then
        XCTAssertEqual(apiManagerUnderTest.propertiesArray.count, 5, "Coundn't parse properly")
    }    
}
