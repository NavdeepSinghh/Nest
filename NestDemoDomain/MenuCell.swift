//
//  MenuCell.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/23/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let menuBarItemLabel : UILabel = {
        let label = UILabel()
        label.text = "Rent"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func setupViews(){
    addSubview(menuBarItemLabel)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: menuBarItemLabel)
        addConstraintWithFormat(format: "V:|[v0]|", views: menuBarItemLabel)
    }
}
