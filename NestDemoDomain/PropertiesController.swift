//
//  ViewController.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/22/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

let cellId = "propertyCell"
let cellIdForScrollView  = "cellId"

class PropertiesController: UICollectionViewController{
    
    let apiManager = APIManager.sharedInstance()
    var properties : [Property] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Properties"
        navigationController?.navigationBar.isTranslucent = false
        
        // Accessing Api to get Property results for default choice
        // TODO: Load choices depending on the UserDefaults values
        fetchProperties(for : "")
        
        setupCollectionView()
        setupMenuBar()
    }
    
    func fetchProperties(for : String) {
        apiManager.getPropertyResults(for: "") { (properties, errorMessage) in
            if let properties = properties {
                self.properties = properties
                self.collectionView?.reloadData()
            }
            if errorMessage.isEmpty {print("Search Error :" + errorMessage)}
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdForScrollView, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexpath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexpath , animated: true, scrollPosition: [])
    }
    
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
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
        //collectionView?.register(PropertyCell.self, forCellWithReuseIdentifier: cellId)
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdForScrollView)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellIdForScrollView)
        
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
}
