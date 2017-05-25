//
//  FeedCell.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/25/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
    
    
    let apiManager = APIManager.sharedInstance()
    var properties : [Property] = []
    let propertyCellId = "propertyCell"

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
        fetchProperties(for : "")
        
        addSubview(collectionView)
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(PropertyCell.self, forCellWithReuseIdentifier: propertyCellId)
    }
    
    func fetchProperties(for : String) {
        apiManager.getPropertyResults(for: "") { (properties, errorMessage) in
            if let properties = properties {
                self.properties = properties
                self.collectionView.reloadData()
            }
            if errorMessage.isEmpty {print("Search Error :" + errorMessage)}
        }
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PropertyCell
            cell.property = properties[indexPath.row]
            return cell
        }
}

extension FeedCell : UICollectionViewDelegateFlowLayout{
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
            // Adjusting accroding to the screen ratios available
            let height = (frame.width - 32) * 9 / 16
            return CGSize(width: frame.width, height: height + 16 + 68)
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
}
