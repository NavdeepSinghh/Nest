//
//  FeedCell.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/25/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
    
    var properties : [Property] = []
    let propertyCellId = "propertyCell"
    var navItem = UINavigationItem(title: "Test")
    var horizontalSize : UIUserInterfaceSizeClass?
    var verticalSize : UIUserInterfaceSizeClass?

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()    
    
    override func setupViews() {
        super.setupViews()
        
        // TODO: Load choices depending on the UserDefaults values
        fetchProperties(for: "Rent")
        
        addSubview(collectionView)
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(PropertyCell.self, forCellWithReuseIdentifier: propertyCellId)
    }
    
    func fetchProperties(for tab : String) {
        APIManager.sharedInstance().getPropertyResults(for: tab) { (properties, errorMessage) in
            if let properties = properties {
                self.properties = properties
                self.collectionView.reloadData()
            }
            if !errorMessage.isEmpty {print("Search Error :" + errorMessage)}
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        horizontalSize = traitCollection.horizontalSizeClass
        collectionView.reloadData()
    }
    
}

extension FeedCell : UICollectionViewDelegate {
    
}

extension FeedCell : UICollectionViewDataSource{
    
        //Configuring collectionView
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return properties.count
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: propertyCellId, for: indexPath) as! PropertyCell
            cell.property = properties[indexPath.row]
            cell.navItem = self.navItem
            return cell
        }
}


extension FeedCell : UICollectionViewDelegateFlowLayout{
    
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
            var height = (frame.width - 32) * 9 / 16 + 16 + 68
            var width = frame.width
            if horizontalSize == .regular {
                height = (frame.width/2 - 16) * 9 / 16 + 16 + 68
                width = width / 2.03
            }
            // Adjusting according to the screen ratios available
            return CGSize(width: width, height: height )
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
}
