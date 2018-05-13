//
//  VenueListRouter.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 08/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import UIKit

class VenueListRouter: VenueListWireFrame {

    weak var viewController: UIViewController?

    func presentVenueDetail(_ venue: Venue) {
        let venueDetail = VenueDetailRouter.assembleModule(with: venue)
        viewController?.navigationController?.pushViewController(venueDetail, animated: true)
    }

    func presentAlert(title: String, message: String, actionTitle: String?, action: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle ?? "OK", style: .default, handler: { _ in
            action?()
        }))
        viewController?.present(alert, animated: true, completion: nil)
    }

    static func assembleModule() -> UIViewController {
        let viewController: VenueListViewController = UIStoryboard(name: "VenueList", bundle: nil).createViewController(withIdentifier: "VenueList")

        let router = VenueListRouter()
        let interactor = VenueListInteractor(connection: FourSquareRestConnection.defaultInstance(), locationFetcher: LocationManager.sharedInstance)
        let presenter = VenueListPresenter(router: router, interactor: interactor)
        let dataManager = VenueListDataManager()
        dataManager.dataStore = VenueCoreDataStore()

        viewController.presenter = presenter
        presenter.view = viewController
        interactor.output = presenter
        interactor.dataProvider = dataManager
        router.viewController = viewController

        return viewController
    }
}
