//
//  VenueListDataManager.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 13/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import Foundation

class VenueListDataManager: VenueListDataProvider {
    var dataStore: VenueDataStore?

    func getDislikedVenueIds(handler: @escaping ([String]) -> Void) {
        dataStore?.fetchDislikedVenues(handler: { venueIds in
            handler(venueIds)
        })
    }
}
