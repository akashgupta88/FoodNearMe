//
//  VenueListInteractor.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 08/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import Foundation

class VenueListInteractor: VenueListUseCase {

    weak var output: VenueListInteractorOutput?

    let connection: FourSquareConnection
    let locationFetcher: LocationFetcher

    init(connection: FourSquareConnection, locationFetcher: LocationFetcher) {
        self.connection = connection
        self.locationFetcher = locationFetcher
    }

    func fetchVenueList() {
        locationFetcher.getCurrentLocation { [weak self] result in
            switch result {
            case .location(let location):
                self?.connection.fetchFoodVenues(lat: location.coordinate.latitude,
                                           lon: location.coordinate.longitude,
                                           success: { venues in
                    self?.output?.venueListFetched(venues)
                }, failure: { error in
                    self?.output?.venueListFetchFailed(error: error.localizedDescription)
                })
            case .error(let locationError):
                self?.output?.venueListFetchFailed(error: locationError.description())
            }
        }
    }
}
