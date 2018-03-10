//
//  MockServiceWithNoItems.swift
//  AlamofireContributorsTests
//
//  Created by ashy on 2/27/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import XCTest
@testable import AlamofireContributors

class MockServiceWithNoItems: AlamofireContributorsAPI {
    func fetchContributors(page: Int, completion: @escaping ((Result<[Contributor]>) -> Void)) {
        completion(Result.success([]))
    }
    
    func fetchContributorDetails(login: String, completion: @escaping ((Result<ContributorDetails>) -> Void)) {
        
    }
}
