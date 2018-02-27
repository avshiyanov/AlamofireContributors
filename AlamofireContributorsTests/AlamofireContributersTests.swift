//
//  AlamofireContributersTests.swift
//  AlamofireContributersTests
//
//  Created by ashy on 2/26/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import XCTest
import Alamofire
@testable import AlamofireContributors

class AlamofireContributersTests: XCTestCase {
    
    let contributorsListController: ContributorsListController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let contributorsViewController = navigationController.topViewController as! ContributorsListController
        let view = contributorsViewController.view // force load view
        return contributorsViewController
    }()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - Parsing
    
    func testContributorParsing() {
        let payload: [String: Any] = [
            "id": 169110,
            "login": "cnoon",
            "avatar_url": "https://avatars1.githubusercontent.com/u/169110",
        ]
        let decoder = JSONDecoder()
        do {
            let data = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
            let contributor = try decoder.decode(Contributor.self, from: data)
            XCTAssertEqual(contributor.userId, 169110)
            XCTAssertEqual(contributor.login, "cnoon")
            XCTAssertEqual(contributor.avatarURL, URL(string: "https://avatars1.githubusercontent.com/u/169110"))
        } catch {
        
        }
    }
    
    func testContributorDetailsParsing() {
        let payload: [String: Any] = [
            "name": "Christian Noon",
            "company": "@Nike-Inc",
            "avatar_url": "https://avatars0.githubusercontent.com/u/169110?s=460&v=4",
            ]
        let decoder = JSONDecoder()
        do {
            let data = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
            let contributorDetails = try decoder.decode(ContributorDetails.self, from: data)
            XCTAssertEqual(contributorDetails.name, "Christian Noon")
            XCTAssertEqual(contributorDetails.company, "@Nike-Inc")
            XCTAssertEqual(contributorDetails.avatarURL, URL(string: "https://avatars0.githubusercontent.com/u/169110?s=460&v=4"))
        } catch {
            
        }
    }
    
    // MARK: States
    
    func testOneItemState() {
        contributorsListController.networkService = MockServiceWithOneItem()
        contributorsListController.networkService.fetchContributors { (result) in
            switch (result) {
            case .success(let contributors):
                XCTAssertEqual(contributors.count, 1)
            case .failure(_):
                 XCTFail()
            }
        }
    }
    
    func testNoItemsState() {
        contributorsListController.networkService = MockServiceWithNoItems()
        contributorsListController.networkService.fetchContributors { (result) in
            switch (result) {
            case .success(let contributors):
                XCTAssertEqual(contributors.count, 0)
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    func testNoDataErrorState() {
        contributorsListController.networkService = MockServiceWithNoDataError()
        contributorsListController.networkService.fetchContributors { (result) in
            switch (result) {
            case .failure(let error):
                XCTAssert(error is ResponseError)
                XCTAssertEqual((error as! ResponseError), ResponseError.empty)
            case .success:
                XCTFail()
            }
        }
    }
    
    func testErrorState() {
        contributorsListController.networkService = MockServiceWithError()
        contributorsListController.networkService.fetchContributors { (result) in
            switch (result) {
            case .failure(let error):
                XCTAssert(error is ResponseError)
                XCTAssertEqual((error as! ResponseError), ResponseError.parse)
            case .success:
                XCTFail()
            }
        }
    }
}
