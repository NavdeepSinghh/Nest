//
//  PropertiesController+CollectionViewDelegates.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/23/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

extension PropertiesController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Proper sizing of the cells : Give space to menubar by 50
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }

}

// UICollectionViewDataSource methods 
extension PropertiesController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier : String
        
        if indexPath.item == 1 {
            cellIdentifier = buyCellId
        }else {
            cellIdentifier = rentCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FeedCell
        cell.navItem = self.rightButton
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}

// UIScollViewDelegate methods
extension PropertiesController {
        
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexpath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexpath , animated: true, scrollPosition: [])
    }
}

