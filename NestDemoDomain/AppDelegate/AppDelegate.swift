//
//  AppDelegate.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/22/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var set : Set<Int>!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let propertiesController = PropertiesController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: propertiesController)
        window?.rootViewController = navigationController
        
        // Remove the NavBar line
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        UINavigationBar.appearance().barTintColor = UIColor.getColor(red: 0, green: 200, blue: 0)
        // Making the status bar colour white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.boldSystemFont(ofSize: 22)]
        application.statusBarStyle = .lightContent
        
        // Adding status bar background
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.getColor(red: 0, green: 200, blue: 0)
        statusBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        window?.addSubview(statusBarBackgroundView)
        window?.addConstraintWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        window?.addConstraintWithFormat(format: "V:|[v0(20)]", views: statusBarBackgroundView)
        
        // For default selected MenuBarItem
        if UserDefaults.standard.string(forKey: "selectedMenuItem") == nil {
            UserDefaults.standard.set("Rent", forKey: "selectedMenuItem")
        }
        
        // To maintain the state of the likes in app
        set = Set<Int> ()
        if let arrayFromUserDefaults = UserDefaults.standard.array(forKey: "likedProperties") as? [Int] {
            set = Set(arrayFromUserDefaults.map{
                return $0
            })
        }
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Saving the liked state when the app goes to background
        let arrayOfIds : [Int] = set.map{
            return $0
        }
        UserDefaults.standard.set(arrayOfIds, forKey: "likedProperties")
    }
}

