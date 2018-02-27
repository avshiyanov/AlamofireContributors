//
//  ContributerDetailsViewController.swift
//  AlamofireContributers
//
//  Created by ashy on 2/27/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import UIKit

class ContributorDetailsViewController: UIViewController {
    // MARK: IBOutles
    @IBOutlet private var logoImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var bioLabel: UILabel!
    @IBOutlet private var companyLabel: UILabel!
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
    // MARK: Properties
    var networkService: AlamofireContributorsAPI = {
        return NetworkService()
    }()
    var alertInterupter: AlertViewInterupter = {
        return AlertViewInterupter()
    }()
    var contributor: Contributor!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        requestData()
    }
    
    // MARK: -
    
    func configureView() {
        nameLabel.text = nil
        companyLabel.text = nil
        bioLabel.text = nil
    }
    
    func requestData() {
        spinner.startAnimating()
        networkService.fetchContributorDetails(login: contributor.login) { [weak self] (result) in
            guard let `self` = self else { return }
            self.spinner.stopAnimating()
            switch (result) {
            case .success(let contributorDetails):
                self.update(with: contributorDetails)
            case .failure(let error):
                self.alertInterupter.presentAlert(with: error, presenter: self)
            }
        }
    }
    
    func update(with contributorDetails: ContributorDetails) {
        logoImageView.af_setImage(withURL: contributorDetails.avatarURL)
        nameLabel.text = contributorDetails.name
        companyLabel.text = contributorDetails.company
        bioLabel.text = contributorDetails.bio
    }
}
