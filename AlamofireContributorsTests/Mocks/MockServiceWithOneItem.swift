//
//  MockServiceWithOneItem.swift
//  AlamofireContributorsTests
//
//  Created by ashy on 2/27/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import XCTest
@testable import AlamofireContributors

class MockServiceWithOneItem: AlamofireContributorsAPI {
    func fetchContributors(completion: @escaping ((Result<[Contributor]>) -> Void)) {
        let payload: [String: Any] = [
            "id": 169110,
            "login": "cnoon",
            "avatar_url": "https://avatars1.githubusercontent.com/u/169110",
            ]
        let decoder = JSONDecoder()
        do {
            let data = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
            let contributor = try decoder.decode(Contributor.self, from: data)
            completion(Result.success([contributor]))
        } catch {
            completion(Result.failure(ResponseError.parse))
        }
    }
    
    func fetchContributorDetails(login: String, completion: @escaping ((Result<ContributorDetails>) -> Void)) {
        
    }
}
