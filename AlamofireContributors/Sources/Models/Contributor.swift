//
//  Contributer.swift
//  AlamofireContributers
//
//  Created by ashy on 2/26/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import Foundation

struct Contributor: Decodable {
    let userId: Int
    let avatarURL: URL
    let login: String
    
    private enum CodingKeys: String, CodingKey {
        case userId = "id"
        case avatarURL = "avatar_url"
        case login
    }
}
