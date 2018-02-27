//
//  ViewController.swift
//  AlamofireContributers
//
//  Created by ashy on 2/26/18.
//  Copyright © 2018 ashy. All rights reserved.
//

import UIKit

class ContributorsListController: UITableViewController {
    // MARK: Properties
    private var spinner: UIActivityIndicatorView!
    var networkService: AlamofireContributorsAPI = {
        return NetworkService()
    }()
    var alertInterupter: AlertViewInterupter = {
        return AlertViewInterupter()
    }()
    var contributors: [Contributor]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        // Do any additional setup after loading the view, typically from a nib.
        requestData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? ContributorDetailsViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            detailsViewController.contributor = contributors?[indexPath.row]
        }
    }
    
    // MARK: -
    
    func configureView() {
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.hidesWhenStopped = true
        tableView.backgroundView = spinner
        tableView.tableFooterView = UIView()
    }
    
    func requestData() {
        spinner.startAnimating()
        networkService.fetchContributors { [weak self] (result) in
            guard let `self` = self else { return }
            self.spinner.stopAnimating()
            switch (result) {
            case .success(let contributors):
                self.contributors = contributors
            case .failure(let error):
                self.alertInterupter.presentAlert(with: error, presenter: self)
            }
        }
    }
    
    // MARK: UITableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contributors = self.contributors else {
            return 0
        }
        return contributors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contributors = self.contributors else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContributorTableViewCell.self), for: indexPath) as! ContributorTableViewCell
        cell.update(with: contributors[indexPath.row])
        
        return cell
    }

}

