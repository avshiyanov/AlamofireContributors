//
//  NetworkProtocol.swift
//  AlamofireContributers
//
//  Created by ashy on 2/26/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import Foundation
import Alamofire

public protocol NetworkProtocol {
    func makeRequest(completion: @escaping ((Alamofire.DataResponse<Any>) -> Void))
}

