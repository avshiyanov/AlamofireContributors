//
//  AlertViewInterupter.swift
//  AlamofireContributers
//
//  Created by ashy on 2/27/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import Foundation
import UIKit

struct AlertViewInterupter {
    func presentAlert(with error: Error?, presenter: UIViewController) {
        let errorMessage: String
        switch error {
        case let responseError as ResponseError:  errorMessage = responseError.localizedDescription
        case .some(let error):                    errorMessage = error.localizedDescription
        case .none:                               errorMessage = NSLocalizedString("ErrorUnknown", comment: "")
        }
        let alertController = UIAlertController(title: errorMessage, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                         style: .default, handler: nil)
        alertController.addAction(cancelAction)
        presenter.present(alertController, animated: true, completion: nil)
    }
}
