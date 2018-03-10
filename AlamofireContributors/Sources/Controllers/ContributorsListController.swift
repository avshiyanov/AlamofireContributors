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
    private var refreshView: UIRefreshControl!
    var currentPage: Int = 1
    var requestIsExecuted = false
    var networkService: AlamofireContributorsAPI = {
        return NetworkService()
    }()
    var alertInterupter: AlertViewInterupter = {
        return AlertViewInterupter()
    }()
    var contributors: [Contributor] = [Contributor]()
    
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
            detailsViewController.contributor = contributors[indexPath.row]
        }
    }
    
    // MARK: -
    
    func configureView() {
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.hidesWhenStopped = true
        tableView.backgroundView = spinner
        tableView.tableFooterView = UIView()
        refreshView = UIRefreshControl()
        refreshView.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl = refreshView
    }
    
    func requestData() {
        spinner.startAnimating()
        requestIsExecuted = true
        networkService.fetchContributors(page: currentPage) {  [weak self] (result) in
            guard let `self` = self else { return }
            self.spinner.stopAnimating()
            self.refreshView.endRefreshing()
            self.requestIsExecuted = false
            switch (result) {
            case .success(let contributors):
                self.addContributors(contributors)
            case .failure(let error):
                self.alertInterupter.presentAlert(with: error, presenter: self)
            }
        }
    }
    
    func addContributors(_ contributors:[Contributor]) {
        if self.contributors.isEmpty {
            self.contributors = contributors
        } else {
            self.contributors.append(contentsOf: contributors)
        }
        self.tableView.reloadData()
    }
    
    @objc func refresh() {
        currentPage = 1
        contributors = []
        requestData()
    }
    
    func loadMore() {
        if requestIsExecuted { return }
        currentPage += 1
        requestData()
    }
    
    // MARK: UITableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contributors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContributorTableViewCell.self), for: indexPath) as! ContributorTableViewCell
        cell.update(with: contributors[indexPath.row])
        
        return cell
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.tableView.isNearTheBottomEdge(scrollView.contentOffset) {
            loadMore()
        }
    }

}

