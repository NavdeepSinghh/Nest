//
//  NestDemoDomainTests.swift
//  NestDemoDomainTests
//
//  Created by Navdeep  Singh on 5/30/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import XCTest
@testable import NestDemoDomain

class NestDemoDomainTests: XCTestCase {
    
    var apiManager : APIManager!
    var data : Data!
    let dummyPropertyDictionary : [String : Any] =
        
        ["promo_level" : "P+" ,
        "id": 2013612324 ,
        "media": [[
        "media_type" : "image",
        "type": "photo",
        "image_url": "https://bucket-api.domain.com.au/v1/bucket/image/2013600063_1_pi_170517_031444-w800-h599"
    ]],
        "headline": "Panoramic Views",
        "address": "110 Old Tathra Rd, Merimbula",
        "lifecycle_status": "New",
        "listing_type": "topspot",
        "homepass_enabled": false]
    
    override func setUp() {
        super.setUp()
        apiManager = APIManager()
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Test", ofType: "json")
        data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
    }
    
    override func tearDown() {
        data = nil
        super.tearDown()
    }
    
    // To check if the initializer works fine for the propety Model
    // Tweak the dummyDictionary to send invalid responses to the initializer
    // In case the id is removed, the object will not be created
    func testPropertyModelInitializationForWrongValues () {
        let property = Property(dictionary: dummyPropertyDictionary as [String : AnyObject])
        XCTAssertEqual(property.propertyID, 2013612324 , "Coundn't parse properly")
        XCTAssertEqual(property.propertyImageURLString, "https://bucket-api.domain.com.au/v1/bucket/image/2013600063_1_pi_170517_031444-w800-h599" , "Coundn't parse properly")
        XCTAssertEqual(property.descriptionText, "Panoramic Views" , "Coundn't parse properly")
        XCTAssertEqual(property.isLiked, false , "Coundn't parse properly")
    }
    
    // Checking the data parsing function of APIManager ..
    // Special case when id is not present, how many objects are created : Deleting id from one of the objects
    // We get only 4 objects but the file contains 5 objects (one without id)
    func testupdatePropertiesSearchResults() {
        apiManager.updatePropertiesSearchResults(with : data){ result in
            switch result {
            case .success(_):
                XCTAssertEqual(apiManager.propertiesArray.count, 4, "Coundn't parse properly")
            case let .failure(error) :
                XCTFail("failure Reason = \(error)")
            }
        }
    }
    
    // Performance checking to see the performance of this function
    // In order to set the metrics for this method run the tests and set performance metrics by editing the scheme
    // The test will fail or pass depending on the set scheme
    func testMeasurePerformanceOfUpdateSearchResults(){
        measure {
            self.apiManager.updatePropertiesSearchResults(with : self.data){ result in
                switch result {
                case .success(_):
                    XCTAssertEqual(self.apiManager.propertiesArray.count, 4, "Coundn't parse properly")
                case let .failure(error) :
                    XCTFail("failure Reason = \(error)")
                }
            }
        }
    }
}
