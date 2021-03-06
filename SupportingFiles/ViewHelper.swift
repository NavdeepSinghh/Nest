//
//  ViewHelper.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/22/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func createAlert(message : String) -> UIAlertController{
        let alert = UIAlertController.init(title: "Warniing!!!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        return alert
    }
}

//convenience method to get UIColor value
extension UIColor {
    static func getColor(red: CGFloat, green : CGFloat, blue : CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

// Helper method to add constraints to the view
extension UIView {
    
    func addConstraintWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

// Implementing cache to fetch images if already present in local cache
let imageCache = NSCache<NSString , UIImage>()

class ImageViewCustom :  UIImageView {
    
    var imageUrlString : String?
    // Making this function more testable
    func loadImageUsingURLString(urlString: String, completion : ((Bool) -> Void)?){
        
        imageUrlString = urlString
        guard let url = URL(string: urlString) else {
            completion?(false)
            return
        }
        
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as NSString){
            self.image = imageFromCache
            completion?(true)
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                completion?(true)
                DispatchQueue.main.async {
                    if let imageToBeStoredInCache = UIImage(data: data){
                        if self.imageUrlString == urlString{
                            self.image = imageToBeStoredInCache
                        }                        
                        imageCache.setObject(imageToBeStoredInCache, forKey: urlString as NSString)
                    }
                }
            }
        }).resume()
    }
}
