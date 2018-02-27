//
//  Alamofire.DataResponse.swift
//  AlamofireContributers
//
//  Created by ashy on 2/27/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import Foundation
import Alamofire

extension Alamofire.DataResponse {
    func parseArray<T: Decodable>() -> Result<[T]> {
        if let error = self.error { return .failure(error) }
        guard let data = self.data else {
            return .failure(ResponseError.empty)
        }
        let decoder = JSONDecoder()
        do {
            let resultArray = try decoder.decode([T].self, from: data)
            return .success(resultArray)
        } catch  {
            return .failure(ResponseError.parse)
        }
    }
    
    func parse<T: Decodable>() -> Result<T> {
        if let error = self.error { return .failure(error) }
        guard let data = self.data else {
            return .failure(ResponseError.empty)
        }
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(T.self, from: data)
            return .success(result)
        } catch  {
            return .failure(ResponseError.parse)
        }
    }
}
