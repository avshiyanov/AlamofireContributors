//
//  MockServiceWithError.swift
//  AlamofireContributersTests
//
//  Created by ashy on 2/27/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import XCTest
@testable import AlamofireContributors

class MockServiceWithError: AlamofireContributorsAPI {
    func fetchContributors(completion: @escaping ((Result<[Contributor]>) -> Void)) {
        completion(Result.failure(ResponseError.parse))
    }
    
    func fetchContributorDetails(login: String, completion: @escaping ((Result<ContributorDetails>) -> Void)) {
        completion(Result.failure(ResponseError.parse))
    }
}
