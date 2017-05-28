//
//  PropertiesRequestRouter.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/25/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import Foundation

public enum PropertiesRequestRouter {
    
    // Possible requests 
    case create ([String: Any])
    
    // Base endpoint
    static let baseUrlString = "https://mobile-adapter-api.domain.com.au/v1/search"
    
    // Set the method
    var method : String{
        switch self {
        case .create:
            return "POST"
        }
    }
    
    // Create request from url, method and parameters 
    public func asURLRequest() -> URLRequest {
        let url : URL = {
            let url = URL(string: PropertiesRequestRouter.baseUrlString)!
            return url
        }()
        
        // Setup request parameters (body)
        
        let parameters : [String: Any]? = {
            switch self {
            case .create (let post):
                return post
            }
        }()
        
        // Create request 
        var request = URLRequest(url: url)
        
        // Setup HTTP method
        request.httpMethod = self.method
        
        // Convert parameters to data and set httpBody
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        return request
    }
}
