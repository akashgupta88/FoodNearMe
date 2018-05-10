//
//  VenueListViewController.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 09/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import UIKit

class VenueListViewController: UIViewController, VenueListView {
    var presenter: VenueListPresentation?

    var venueViewModels: VenueListViewModel?

    @IBOutlet weak var tableView: UITableView?
    let reuseIdentifier = "VenueCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    func showNoVenueFoundMessage() {
        
    }

    func showVenueList(_ viewModel: VenueListViewModel) {
        self.venueViewModels = viewModel
        self.tableView?.reloadData()
    }
}

extension VenueListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venueViewModels?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)

        if let viewModel = venueViewModels?[indexPath.row] {
            cell.textLabel?.text = viewModel.name
            cell.detailTextLabel?.text = viewModel.distance
        }

        return cell
    }
}

extension VenueListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectVenue(index: indexPath.row)
    }
}
