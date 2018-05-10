//
//  VenueListViewModel.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 08/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import Foundation

typealias VenueListViewModel = [VenueViewModel]

struct VenueViewModel {
    let name: String
    let distance: String
    let imageURL: String
}
