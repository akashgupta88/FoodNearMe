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

    func viewWillAppear() {

    }

    func didSelectVenue(_ venue: Venue) {

    }
}
