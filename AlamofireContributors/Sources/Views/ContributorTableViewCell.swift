//
//  ContributorTableViewCell.swift
//  AlamofireContributers
//
//  Created by ashy on 2/27/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import UIKit
import AlamofireImage

class ContributorTableViewCell: UITableViewCell {
    // 
    @IBOutlet private var logoImageView: UIImageView!
    @IBOutlet private var loginNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loginNameLabel.textColor = UIColor.blue
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImageView.af_cancelImageRequest()
        logoImageView.image = nil
        loginNameLabel.text = nil
    }
    
    func update(with contributor: Contributor) {
        logoImageView.af_setImage(withURL: contributor.avatarURL)
        loginNameLabel.text = contributor.login
    }
}
