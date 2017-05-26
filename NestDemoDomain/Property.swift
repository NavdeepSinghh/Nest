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
    var propertyImageURLString : String?
    var descriptionText : String?
    var isLiked : Bool?
    
    var imagesArray : [String]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "id" {
            self.propertyID = value as? Int
        } else if key == "headline"{
            self.descriptionText = value as? String
        }else if key == "media"{
            let mediaDictionary = value as? [[String: Any]]
            if let mediaDictionary = mediaDictionary{
                if !mediaDictionary.isEmpty{
                    // Getting first image_url from the available dictionary
                    if  let image_url = mediaDictionary[0]["image_url"] as? String{
                        self.propertyImageURLString = image_url
                    }
                }
            }
        }
        self.isLiked = true
    }
    
    init(dictionary : [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}
