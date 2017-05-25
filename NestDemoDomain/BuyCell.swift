//
//  BuyCell.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/25/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

class BuyCell: FeedCell {

    override func fetchProperties(for: String) {
        APIManager._sharedinstance.getPropertyResults(for: "") { (properties, errorMessage) in
            if let properties = properties {
                self.properties = properties
                self.collectionView.reloadData()
            }
            if errorMessage.isEmpty {print("Search Error :" + errorMessage)}
        }
    }
}
