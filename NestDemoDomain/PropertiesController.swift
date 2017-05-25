//
//  ViewController.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/22/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

class PropertiesController: UICollectionViewController{
    
    
    let rentCell  = "rentCell"
    let buyCellId = "buyCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Properties"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.hidesBarsOnSwipe = true
        
        setupCollectionView()
        setupMenuBar()
    }
    
    
    lazy var menuBar : MenuBar = {
        let menu = MenuBar()
        menu.propertiesController = self
        return menu
    }()
    
    func setupCollectionView(){
        
        // Changing the scroll direction for the collectionView
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.isPagingEnabled = true
        
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: rentCell)
        collectionView?.register(BuyCell.self, forCellWithReuseIdentifier: buyCellId)
        
       // To Re-adjust collectionView under the menubar
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    private func setupMenuBar(){
        
        navigationController?.hidesBarsOnSwipe = true
        
        // View to fix abnormal scrolling
        let backgroundFixView = UIView()
        backgroundFixView.backgroundColor = UIColor.getColor(red: 0, green: 200, blue: 0)
        
        view.addSubview(backgroundFixView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: backgroundFixView)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: backgroundFixView)
        
        view.addSubview(menuBar)        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true       
    }
    
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
    }
}
