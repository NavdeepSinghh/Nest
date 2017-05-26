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
    var requestBodyDictForRent : JSONDictionary = ["dwelling_types": ["Apartment / Unit / Flat"],
                    "search_mode": "rent"]
    var requestBodyDictForBuy : JSONDictionary = ["dwelling_types": ["Apartment / Unit / Flat"],
                                              "search_mode": "buy"]
    
    // To test response from the APIManager : For testing purpose
    var defaultSession : MockURLSession = URLSession(configuration: .default)
    var errorMessage = ""
    
    func getPropertyResults(for tab: String, completion: @escaping QueryResult){
        dataTask?.cancel()
        
        // Considering default case is buy
        var requestParameters : JSONDictionary
        
        if tab == "Rent"{
            requestParameters = requestBodyDictForRent
        }else{
            requestParameters = requestBodyDictForBuy
        }
        // Getting the request from Request Router
        var request = PropertiesRequestRouter.create(requestParameters).asURLRequest()
        dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
            defer {self.dataTask = nil}
            
            if let error = error {
                self.errorMessage += "Datatask error:" + error.localizedDescription + "\n"
            } else if let data = data,
            let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updatePropertiesSearchResults(with: data)
                DispatchQueue.main.async {
                    completion(self.propertiesArray, self.errorMessage)
                }
            } else{
                if let res = response as? HTTPURLResponse{
                    print(res.statusCode )
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
        
        guard let array = response!["search_results"] as? [[String: AnyObject]] else {
            errorMessage += "Dictionary does not contain search_results key \n"
            return
        }       
        
        for propertyDictionary in array  {            
            let property = Property(dictionary : propertyDictionary)
            propertiesArray.append(property)
        }
    }
}
