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
    
    // Calculate the horizontal cell size using size classes
    var height : CGFloat!
    var width : CGFloat!
    fileprivate var aspectRatio : CGSize{
        switch traitCollection.horizontalSizeClass {
        case .compact:
            height = (frame.width - 32) * 9 / 16 + 16 + 68
            width = frame.width
        default:
            height = (frame.width / 2 - 16) * 9 / 16 + 16 + 68
            width = frame.width / 2.03
            }
        return CGSize(width: width, height: height)
    }

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
        APIManager.sharedInstance().getPropertyResults(for: tab) {result in
            switch result {
        case let .success(propertiesArray):
            self.properties = propertiesArray
            DispatchQueue.main.async {                
                self.collectionView.reloadData()
            }
        case let .failure(error) : print(error)
            }
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: propertyCellId, for: indexPath) as! PropertyCell
            cell.property = properties[indexPath.row]
            cell.navItem = self.navItem
            return cell
        }
}

extension FeedCell : UICollectionViewDelegateFlowLayout{
    
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
            // Adjusting according to the screen ratios available
            return aspectRatio
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
}
