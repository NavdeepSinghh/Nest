//
//  APIErrors.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/30/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import Foundation

enum APIErrors : Error {
    // More generalized versions of these cases can be formed for extensive error handling
    case requestFailed(error: NSError)
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case invalidURL
    case jsonParsingFailure
}

enum Result <Value, Error> {
    case success(Value)
    case failure(Error)
}
