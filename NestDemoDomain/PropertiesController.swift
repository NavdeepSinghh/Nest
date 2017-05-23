//
//  ViewController.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/22/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

let cellId = "propertyCell"

class PropertiesController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
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
    
    // Configuring collectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return properties.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PropertyCell
        cell.property = properties[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Adjusting accroding to the screen ratios available
        let height = (view.frame.width - 32) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 68)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

