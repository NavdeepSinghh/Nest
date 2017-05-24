//
//  ViewHelper.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/22/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

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

extension UIImageView {
    
    func loadImageUsingURLString(urlString: String){
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}
