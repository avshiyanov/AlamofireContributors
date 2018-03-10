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
    let parameters: Parameters?
    
    private enum Constants {
        static let baseURL = "https://api.github.com"
        static let token = "8a7a872d62d6400904bd8d3defd40f1411af94cb"
    }
    
    public var sharedHeaders: HTTPHeaders {
        return ["Authorization": "token " + Constants.token]
    }
    
    public init(path: String, method: HTTPMethod, parameters: Parameters? = nil) {
        self.method = method
        self.parameters = parameters
        self.path = path
    }
    
    public func makeRequest(completion: @escaping ((Alamofire.DataResponse<Any>) -> Void)) {
    
        Alamofire.request(Constants.baseURL + path, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: self.sharedHeaders).validate().responseJSON { (response) in
                completion(response)
        }
    }
}
