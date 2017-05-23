//
//  MenuCell.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/23/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
   
    let menuBarItemLabel : UILabel = {
        let label = UILabel()
        label.text = "Rent"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    override func setupViews(){
    addSubview(menuBarItemLabel)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: menuBarItemLabel)
        addConstraintWithFormat(format: "V:|[v0]|", views: menuBarItemLabel)
    }
}
