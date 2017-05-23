//
//  ViewController.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/22/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

let cellId = "propertyCell"

class PropertiesController: UICollectionViewController{
    
    var properties : [Property] = {
        let property1 = Property(propertyId: 1, propertyImage: "Test.jpeg", descriptionText: "Dummy Text", isLiked: true)
        let property2 = Property(propertyId: 2, propertyImage: "Test.jpeg", descriptionText: "Dummy text for item at index 2 and thi text is long becaue I want to test the height of the label holding this text", isLiked : true)
        return [property1, property2]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Properties"
        navigationController?.navigationBar.isTranslucent = false
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(PropertyCell.self, forCellWithReuseIdentifier: cellId)
        
        // To Re-adjust collectionView under the menubar
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        setupMenuBar()
    }
    
    let menuBar : MenuBar = {
        let menu = MenuBar()
        return menu
    }()
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
}
