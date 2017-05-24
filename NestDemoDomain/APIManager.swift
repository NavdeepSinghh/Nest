//
//  APIManager.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/23/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import Foundation
import UIKit

typealias JSONDictionary = [String: Any]
typealias QueryResult = ([Property]?, String)->()

class APIManager{
    static let _sharedinstance = APIManager()
    static func sharedInstance() -> APIManager{
        return _sharedinstance
    }
    
    var propertiesArray : [Property] = []
    var dataTask : URLSessionDataTask?
    
    // To test response from the APIManager : For testing purpose
    var defaultSession : MockURLSession = URLSession(configuration: .default)
    var errorMessage = ""
    
    func getPropertyResults(for tab: String, completion: @escaping QueryResult){
        dataTask?.cancel()
        
        // Considering default case is buy
        var requestParameters : JSONDictionary = ["dwelling_types": ["Apartment / Unit / Flat"],
                                                  "search_mode": "buy"]
        
        if tab == "Rent"{
            requestParameters = ["dwelling_types": ["Apartment / Unit / Flat"],
                                 "search_mode": "rent"]
    }
        guard let url = URL(string: "https://mobile-adapter-api.domain.com.au/v1/search") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestParameters, options: [])
        
        dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
            defer {self.dataTask = nil}
            
            if let error = error {
                self.errorMessage += "Datatask error:" + error.localizedDescription + "\n"
            } else if let data = data,
            let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                // To Silence the warning 
                _ = self.updatePropertiesSearchResults(with: data)
                DispatchQueue.main.async {
                    completion(self.propertiesArray, self.errorMessage)
                }
            }
        })
        dataTask?.resume()
    }
    
    
    // Helper methd to convert data to response dictionary
    func updatePropertiesSearchResults(with data: Data) {
        var response : JSONDictionary?
        
        propertiesArray.removeAll()
        
        do{
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        }catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)"
            return
        }
        
        guard let array = response!["search_results"] as? [Any] else {
            errorMessage += "Dictionary does not contain search_results key \n"
            return
        }
        
        for propertyDictionary in array {
            if let propertyDictionary = propertyDictionary as? JSONDictionary,
            let id = propertyDictionary["id"] as? Int,
                let description = propertyDictionary["headline"] as? String{
                // Get thumbnail from first media element
                
                if let mediaArray = propertyDictionary["media"] as? [JSONDictionary]{
                    var imageURL = ""
                    for index in 0..<mediaArray.count{
                        let media = mediaArray[index]
                        if let image_url = media["image_url"] as? String{
                            if index == 0 {
                                imageURL = image_url
                            }
                        }
                    }
                    // TODO: change the property on isLiked here it self by comparing it with store array of Userdefaults
                    propertiesArray.append(Property(propertyId: id, propertyImageURLString: imageURL, descriptionText: description, isLiked: false))
                }else{
                    errorMessage += "Error parsing the media dcitionary \n"
                }
            } else{
                errorMessage += "Error parsing the search_results dictionary \n"
            }
        }
    }
}
