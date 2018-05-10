//
//  ListContract.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 08/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import UIKit

protocol VenueListView: class {
    var presenter: VenueListPresentation? { get set }

    func showNoVenueFoundMessage()
    func showVenueList(_ viewModel: VenueListViewModel)
}

protocol VenueListPresentation: class {
    weak var view: VenueListView? { get set }
    var interactor: VenueListUseCase { get }
    var router: VenueListWireFrame { get }

    func viewDidLoad()
    func didSelectVenue(_ venue: Venue)
}

protocol VenueListUseCase: class {
    weak var output: VenueListInteractorOutput? { get set }

    func fetchVenueList()
}

protocol VenueListInteractorOutput: class {
    func venueListFetched(_ venues: [Venue])
    func venueListFetchFailed(error: String?)
}

protocol VenueListWireFrame {
    weak var viewController: UIViewController? { get set }

    func presentVenueDetail(_ venue: Venue)
    func presentAlert(title: String, message: String, actionTitle: String?, action:(() -> Void)?)

    static func assembleModule() -> UIViewController
}
