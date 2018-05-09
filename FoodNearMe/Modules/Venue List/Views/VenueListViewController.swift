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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func showNoVenueFoundMessage() {

    }

    func showVenueList(_ viewModel: VenueListViewModel) {

    }

}
