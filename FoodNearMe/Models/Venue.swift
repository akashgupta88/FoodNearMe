//
//  Venue.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 07/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import Foundation

class Venue: NSObject, Decodable {
    let id: String
    let name: String
    let location: Location

    init(id: String, name: String, location: Location) {
        self.id = id
        self.name = name
        self.location = location
    }

    class Location: NSObject, Decodable {
        let formattedAddress: [String]
        let lat: Double
        let lng: Double
        let distance: Double

        init(formattedAddress: [String], lat: Double, lng: Double, distance: Double) {
            self.formattedAddress = formattedAddress
            self.lat = lat
            self.lng = lng
            self.distance = distance
        }
    }
}
