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
typealias FetchResult = Result<[Property], APIErrors>
typealias QueryCompletion = (_ result : FetchResult) -> Void

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
    
    func getPropertyResults(for tab: String, completion: @escaping QueryCompletion){
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
            
            if error != nil {
                completion(.failure(.requestFailed(error: error! as NSError)))
                return
            } else if let data = data,
            let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updatePropertiesSearchResults(with: data){ result in
                    switch result {
                    case let .success(propertiesArray): completion(.success(propertiesArray))
                    case let .failure(error) : completion(.failure(error))
                    }
                }
            } else{
                if (response as? HTTPURLResponse) != nil{
                    completion(.failure(.responseUnsuccessful))
                }
            }
        })
        dataTask?.resume()
    }
    
    
    // Helper methd to convert data to response dictionary
    // More unit testable by breaking the login this ways
    func updatePropertiesSearchResults(with data: Data, completion: QueryCompletion) {
        var response : JSONDictionary?
        
        propertiesArray.removeAll()
        
        do{
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        }catch _ as NSError {
           completion(.failure(.jsonConversionFailure))
           return
        }
        
        guard let array = response!["search_results"] as? [[String: AnyObject]] else {
            completion(.failure(.jsonParsingFailure))
            return
        }
        
        // FP to refractor and remove any Properties if the id is nil 
        propertiesArray = array.map{
                Property(dictionary: $0)
            }.filter{$0.propertyID != nil}
        completion(.success(self.propertiesArray))
    }
}
