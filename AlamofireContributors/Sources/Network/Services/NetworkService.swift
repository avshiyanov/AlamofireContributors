//
//  GithubApiService.swift
//  AlamofireContributers
//
//  Created by ashy on 2/26/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import Foundation
import Alamofire

public enum ResponseError: Error {
    case empty
    case parse
    
    var localizedDescription: String {
        switch self {
        case .empty:
            return NSLocalizedString("ErrorEmpty", comment: "")
        case .parse:
            return NSLocalizedString("ErrorParse", comment: "")
        }
    }
}

protocol AlamofireContributorsAPI {
    func fetchContributors(page:Int, completion: @escaping ((Result<[Contributor]>) -> Void))
    func fetchContributorDetails(login: String, completion: @escaping ((Result<ContributorDetails>) -> Void))
}

public struct NetworkService: AlamofireContributorsAPI {
    private let kApiClientId = "c194ccbb171abd92c67e"
    private let kApiClientSecret = "0e0e6422d6f18cfaf1cdf853ecbfb129d410cde0"
    private let kAlamofireContributersPath    = "/repos/Alamofire/Alamofire/contributors?per_page=30&page={page}&client_id={client_id}&client_secret={client_secret}"
    private let kAlamofireContributerPath     = "/users/{login}?client_id={client_id}&client_secret={client_secret}"
    
    
    func fetchContributors(page:Int, completion: @escaping ((Result<[Contributor]>) -> Void)) {
        var path = kAlamofireContributersPath
        path = path.replacingOccurrences(of: "{page}", with: String(page))
        path = path.replacingOccurrences(of: "{client_id}", with: kApiClientId)
        path = path.replacingOccurrences(of: "{client_secret}", with: kApiClientSecret)
        let request = NetworkRequest(path: path, method: .get)
        request.makeRequest() { response in
            completion(response.parseArray())
        }
    }
    
    func fetchContributorDetails(login: String, completion: @escaping ((Result<ContributorDetails>) -> Void)) {
        var path = kAlamofireContributerPath
        path = path.replacingOccurrences(of: "{login}", with: login)
        path = path.replacingOccurrences(of: "{client_id}", with: kApiClientId)
        path = path.replacingOccurrences(of: "{client_secret}", with: kApiClientSecret)
        let request = NetworkRequest(path: path, method: .get)
        request.makeRequest() { response in
            completion(response.parse())
        }
    }
}

