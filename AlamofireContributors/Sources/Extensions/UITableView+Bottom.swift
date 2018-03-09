//
//  UITableView+Bottom.swift
//  AlamofireContributors
//
//  Created by ashy on 3/9/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import UIKit

let startLoadingOffset: CGFloat = 20.0

extension UITableView {
    
    func isNearTheBottomEdge(_ contentOffset: CGPoint) -> Bool {
        if contentOffset.y < 0 {
            return false
        }
        let result = contentOffset.y +
            self.bounds.size.height +
            startLoadingOffset > self.contentSize.height
        return result
    }
}
