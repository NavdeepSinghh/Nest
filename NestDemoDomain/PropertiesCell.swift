//
//  PropertiesCell.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/22/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import UIKit

class PropertyCell : BaseCell {
    
    // Concurrent queue required for smooth loading of images in the cells
    let concurrrentQueue = DispatchQueue.global()
    
    var property : Property? {
        didSet {
            self.descriptionLabel.text = property?.descriptionText
            setupPropertyImage()
            if (property?.isLiked) != nil {
                 // setup likedImageView Accordingly
            }else {
                
            }
        }
    }
    
    func setupPropertyImage(){
        if let propertyImageUrl = property?.propertyImageURLString{
            // Call the method to load images asynchronously 
        
            guard let url = URL(string: propertyImageUrl) else {return}
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.propertyImageView.image = UIImage(data: data)
                    }
                }
            }).resume()            
        }
    }
        
    var propertyImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Test")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    var likedImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "star")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = UIColor.darkGray
        label.allowsDefaultTighteningForTruncation = true
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        return label
    }()
    
    let separatorView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.getColor(red: 230, green: 230, blue: 230)
        return view
    }()
    
    override func setupViews(){
        backgroundColor = UIColor.white
        
        // Add subviews 
        addSubview(propertyImageView)
        addSubview(descriptionLabel)
        addSubview(likedImageView)
        addSubview(separatorView)
    
        // Horizontal Constraints
        
        //Horizontal Constraints
        addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: propertyImageView)
        addConstraintWithFormat(format: "H:|-16-[v0(44)]", views: likedImageView)
        //Vertical Constraints
        addConstraintWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: propertyImageView, likedImageView, separatorView)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: separatorView)

        
        //top constraint
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: propertyImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //Left constraint
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .left, relatedBy: .equal, toItem: likedImageView, attribute: .right, multiplier: 1, constant: 8))
        //Right Constraint
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .right, relatedBy: .equal, toItem: propertyImageView, attribute: .right, multiplier: 1, constant: 0))
        //Height constraints
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))

        
    }
}
