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
        APIManager._sharedinstance.getPropertyResults(for: "") { result in
            switch result {
            case let .success(propertiesArray):
                self.properties = propertiesArray
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case let .failure(error) : print(error)
            }
        }
    }
}
