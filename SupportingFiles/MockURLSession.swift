//
//  MockURLSession.swift
//  NestDemoDomain
//
//  Created by Navdeep  Singh on 5/23/17.
//  Copyright © 2017 Navdeep. All rights reserved.
//

import Foundation

public protocol MockURLSession {
    func dataTask (with request: URLRequest, completionHandler: @escaping(Data?, URLResponse?, Error?)-> Void) -> URLSessionDataTask
}

extension URLSession : MockURLSession { }

public final class URLSessionMock : MockURLSession {

    var request : URLRequest?
    private let mockDataTask : MockURLSessionDataTask
    
    public convenience init?(jsonDict: [String: Any], response: URLResponse? = nil, error: Error? = nil) {
        guard let data = try? JSONSerialization.data(withJSONObject: jsonDict, options: []) else { return nil }
        self.init(data: data, response: response, error: error)
    }
    
    public init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        mockDataTask = MockURLSessionDataTask()
        mockDataTask.taskResponse = (data, response, error)
    }
    
    public func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        self.mockDataTask.completionHandler = completionHandler
        return self.mockDataTask
    }
    
    final private class MockURLSessionDataTask : URLSessionDataTask {
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        var taskResponse: (Data?, URLResponse?, Error?)?
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(self.taskResponse?.0, self.taskResponse?.1, self.taskResponse?.2)
            }
        }
    }
}
