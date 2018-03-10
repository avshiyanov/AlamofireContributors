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
        static let token = "aee0611d02b88f552de3f8294a5a7fc3f5791c3f"
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
    
        Alamofire.request(Constants.baseURL + path, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: sharedHeaders).validate().responseJSON { (response) in
                completion(response)
        }
    }
}
