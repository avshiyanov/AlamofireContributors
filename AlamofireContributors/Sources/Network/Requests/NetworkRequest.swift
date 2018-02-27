//
//  NetworkRequest.swift
//  AlamofireContributers
//
//  Created by ashy on 2/26/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import Foundation
import Alamofire

public enum Result<T> {
    case success(T)
    case failure(Error)
}

public struct NetworkRequest: NetworkProtocol {
    let path: String
    let method: HTTPMethod
    let parameters: [String : AnyObject]?
    
    private enum Constants {
        static let baseURL = "https://api.github.com"
    }
    
    public init(path: String, method: HTTPMethod, parameters: [String : AnyObject]? = nil) {
        self.method = method
        self.parameters = parameters
        self.path = path
    }
    
    public func makeRequest(completion: @escaping ((Alamofire.DataResponse<Any>) -> Void)) {
        Alamofire.request(Constants.baseURL + path, method: method, parameters: parameters)
            .validate().responseJSON { (response) in
                completion(response)
        }
    }
}
