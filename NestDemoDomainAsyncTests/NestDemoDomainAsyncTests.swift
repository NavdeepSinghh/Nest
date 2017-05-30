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
    
    // URL string to test if the uiimageviewextension works fine
    var urlString = "https://bucket-api.domain.com.au/v1/bucket/image/2013612324_27_pi_170523_110631-w1920-h1440"
    
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
        let request = PropertiesRequestRouter.create(["dwelling_types": ["Apartment / Unit / Flat"],
                                                      "search_mode": "buy"]).asURLRequest()
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
        let request = PropertiesRequestRouter.create(["dwelling_types": ["Apartment / Unit / Flat"],
                                                      "search_mode": "rent"]).asURLRequest()
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
        // Given
        let request = PropertiesRequestRouter.create(["dwelling_types": ["Apartment / Unit / Flat"],
                                                      "search_mode": "rent"]).asURLRequest()
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
    
    // Testing the method on ImageViewCustom to see if it loads image from urlString
    // The test fails if the url string is incorrect
    func testUIImageExtensionFetchingImage(){
        let image = ImageViewCustom()
        let promise = expectation(description: "Call completes with imageView fetching image data successfully")
        image.loadImageUsingURLString(urlString:urlString){flag in
            if flag == true {
                promise.fulfill()
            }else {
                XCTFail("Image loading failed")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
