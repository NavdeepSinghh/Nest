//
//  Property.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/23/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

class Property: NSObject {
    var propertyID : Int?
    var propertyImage : String?
    var descriptionText : String?
    var isLiked : Bool?
    
    // initializer
    init(propertyId: Int, propertyImage : String, descriptionText : String, isLiked : Bool) {
        self.propertyID = propertyId
        self.propertyImage = propertyImage
        self.descriptionText = descriptionText
        self.isLiked = isLiked
    }
    
}
