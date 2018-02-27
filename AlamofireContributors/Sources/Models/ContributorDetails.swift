//
//  ContributorDetails.swift
//  AlamofireContributers
//
//  Created by ashy on 2/27/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import Foundation

struct ContributorDetails: Decodable {
    let name: String
    let company: String?
    let bio: String?
    let location: String
    let avatarURL: URL
    
    private enum CodingKeys: String, CodingKey {
        case name
        case company
        case bio
        case location
        case avatarURL = "avatar_url"
    }
}
