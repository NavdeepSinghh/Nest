//
//  NestDemoDomainAsyncTests.swift
//  NestDemoDomainAsyncTests
//
//  Created by Navdeep  Singh on 5/23/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import XCTest
@testable import NestDemoDomain

class NestDemoDomainAsyncTests: XCTestCase {
    var sessionUnderTest : URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration : URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    // Slow failure Async test : BUY
    func testValidCallToDomainAPIGetsStatusCodeForBuy200(){
        // Given 
        let url = URL(string: "https://mobile-adapter-api.domain.com.au/v1/search")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let requestParametersForBuy : [String : Any] = ["dwelling_types": ["Apartment / Unit / Flat"],
                                                  "search_mode": "buy"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestParametersForBuy, options: [])
        let promise = expectation(description: "Status code : 200")
        
        // when
        sessionUnderTest.dataTask(with: request) { (data, response, error) in
            // then
            if let error = error{
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else{
                    XCTFail("Status code = \(statusCode)")
                }
            }
        }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // Slow failure Async test : RENT
    func testValidCallToDomainAPIGetsStatusCodeForRent200(){
        // Given
        let url = URL(string: "https://mobile-adapter-api.domain.com.au/v1/search")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let requestParametersForBuy : [String : Any] = ["dwelling_types": ["Apartment / Unit / Flat"],
                                                        "search_mode": "rent"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestParametersForBuy, options: [])
        let promise = expectation(description: "Status code : 200")
        
        // when
        sessionUnderTest.dataTask(with: request) { (data, response, error) in
            // then
            if let error = error{
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else{
                    XCTFail("Status code = \(statusCode)")
                }
            }
            }.resume()
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    
    // Fast Fail : One consolidated call for both 
    func testCallToDomainServerCompletes() {
        //  // Given
        let url = URL(string: "https://mobile-adapter-api.domain.com.au/v1/search")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let requestParametersForBuy : [String : Any] = ["dwelling_types": ["Apartment / Unit / Flat"],
                                                        "search_mode": "rent"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestParametersForBuy, options: [])
        let promise = expectation(description: "Call completes immediately by invoking completion handler")
        var statusCode : Int?
        var responseError : Error?
        
        // When
        sessionUnderTest.dataTask(with: request) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        // Then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
