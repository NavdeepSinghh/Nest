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
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            menuBarItemLabel.textColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            menuBarItemLabel.textColor = isSelected ? UIColor.white : UIColor.darkGray
        }
    }
   
    override func setupViews(){
    addSubview(menuBarItemLabel)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: menuBarItemLabel)
        addConstraintWithFormat(format: "V:|[v0]|", views: menuBarItemLabel)
    }
}
