//
//  VenueListPresenter.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 08/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import Foundation

class VenueListPresenter: VenueListPresentation {

    weak var view: VenueListView?
    let router: VenueListWireFrame
    let interactor: VenueListUseCase

    init(router: VenueListWireFrame, interactor: VenueListUseCase) {
        self.router = router
        self.interactor = interactor
    }

    func viewDidLoad() {
        interactor.fetchVenueList()
    }

    func didSelectVenue(_ venue: Venue) {

    }
}

extension VenueListPresenter: VenueListInteractorOutput {

    func venueListFetched(_ venues: [Venue]) {
        let viewModels = venues.map {
            VenueViewModel(name: $0.name, distance: "\($0.location.distance)", imageURL: "")
        }
        self.view?.showVenueList(viewModels)
    }

    func venueListFetchFailed(error: String?) {
        self.router.presentAlert(title: "Uh Oh",
                                 message: error ?? "There was a problem",
                                 actionTitle: "Retry",
                                 action: { self.interactor.fetchVenueList() })
        self.view?.showNoVenueFoundMessage()
    }
}
