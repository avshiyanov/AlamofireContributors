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
    func fetchContributors(completion: @escaping ((Result<[Contributor]>) -> Void))
    func fetchContributorDetails(login: String, completion: @escaping ((Result<ContributorDetails>) -> Void))
}

public struct NetworkService: AlamofireContributorsAPI {
    private let kAlamofireContributersPath    = "/repos/Alamofire/Alamofire/contributors"
    private let kAlamofireContributerPath     = "/users/{login}"
    
    func fetchContributors(completion: @escaping ((Result<[Contributor]>) -> Void)) {
        let request = NetworkRequest(path: kAlamofireContributersPath, method: .get)
        request.makeRequest() { response in
            completion(response.parseArray())
        }
    }
    
    func fetchContributorDetails(login: String, completion: @escaping ((Result<ContributorDetails>) -> Void)) {
        var path = kAlamofireContributerPath
        path = path.replacingOccurrences(of: "{login}", with: login)
        let request = NetworkRequest(path: path, method: .get)
        request.makeRequest() { response in
            completion(response.parse())
        }
    }
}

