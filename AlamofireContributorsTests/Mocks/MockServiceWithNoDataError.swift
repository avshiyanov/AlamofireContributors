//
//  MockServiceWithNoDataError.swift
//  AlamofireContributorsTests
//
//  Created by ashy on 2/27/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import Foundation

import XCTest
@testable import AlamofireContributors

class MockServiceWithNoDataError: AlamofireContributorsAPI {
    func fetchContributors(page: Int, completion: @escaping ((Result<[Contributor]>) -> Void)) {
        completion(Result.failure(ResponseError.empty))
    }
    
    func fetchContributorDetails(login: String, completion: @escaping ((Result<ContributorDetails>) -> Void)) {
        completion(Result.failure(ResponseError.empty))
    }
}
