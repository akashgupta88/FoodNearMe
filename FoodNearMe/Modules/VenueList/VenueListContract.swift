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
    func viewWillAppear()
    func didSelectVenue(index: Int)
}

protocol VenueListUseCase: class {
    weak var output: VenueListInteractorOutput? { get set }
    var dataProvider: VenueListDataProvider? { get set }

    func fetchVenueList()
    func filterVenueList(_ venues: [Venue])
}

protocol VenueListInteractorOutput: class {
    func venueListFetched(_ venues: [Venue])
    func venueListFetchFailed(error: String?)
    func venueListFiltered(_ venues: [Venue])
}

protocol VenueListWireFrame: class {
    weak var viewController: UIViewController? { get set }

    func presentVenueDetail(_ venue: Venue)
    func presentAlert(title: String, message: String, actionTitle: String?, action:(() -> Void)?)

    static func assembleModule() -> UIViewController
}

protocol VenueListDataProvider: class {
    var dataStore: VenueDataStore? { get set }

    func getDislikedVenueIds(handler: @escaping ([String]) -> Void)
}
