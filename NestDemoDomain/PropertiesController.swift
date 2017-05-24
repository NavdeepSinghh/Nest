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
    
    let apiManager = APIManager.sharedInstance()
    var properties : [Property] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Properties"
        navigationController?.navigationBar.isTranslucent = false
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(PropertyCell.self, forCellWithReuseIdentifier: cellId)
        
        // Accessing Api to get Property results for default choice
        // TODO: Load choices depending on the UserDefaults values 
        apiManager.getPropertyResults(for: "") { (properties, errorMessage) in
            if let properties = properties {
                self.properties = properties
                self.collectionView?.reloadData()
            }
            if errorMessage.isEmpty {print("Search Error :" + errorMessage)}
        }
        
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
