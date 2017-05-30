//
//  MenuCell.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/23/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    var menuItemText : String? {
        didSet {
            if UserDefaults.standard.string(forKey: "selectedMenuItem") == self.menuItemText {
                self.menuBarItemLabel.textColor = UIColor.white                
            } else {
                self.menuBarItemLabel.textColor = UIColor.darkGray
            }
            self.menuBarItemLabel.text = menuItemText
        }
    }
   
    let menuBarItemLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            menuBarItemLabel.textColor = isHighlighted ? UIColor.white : UIColor.darkGray           
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UserDefaults.standard.set(self.menuBarItemLabel.text, forKey: "selectedMenuItem")
            }
            menuBarItemLabel.textColor = isSelected ? UIColor.white : UIColor.darkGray
        }
    }
   
    override func setupViews(){
    addSubview(menuBarItemLabel)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: menuBarItemLabel)
        addConstraintWithFormat(format: "V:|[v0]|", views: menuBarItemLabel)
    }
}
