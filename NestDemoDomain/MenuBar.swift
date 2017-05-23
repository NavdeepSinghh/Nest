//
//  MenuBar.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/22/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

let menuCellId = "menuBarCell"
let menuBarNames = ["Rent", "Buy"]

class MenuBar: UIView, UICollectionViewDelegate {
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.getColor(red: 0, green: 200, blue: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuCellId)
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
    
    }
    
   required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

