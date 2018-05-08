//
//  VenueSpec.swift
//  FoodNearMeTests
//
//  Created by Akash Gupta on 08/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import Foundation
import XCTest
@testable import FoodNearMe

class VenueSpec: XCTestCase {

    func testShouldParseModelFromJSONData() {
        guard let jsonData = """
        {
            "id": "5642aef9498e51025cf4a7a5",
            "name": "Mr. Purple",
            "location": {
              "address": "180 Orchard St",
              "crossStreet": "btwn Houston & Stanton St",
              "lat": 40.72173744277209,
              "lng": -73.98800687282996,
              "labeledLatLngs": [
                {
                  "label": "display",
                  "lat": 40.72173744277209,
                  "lng": -73.98800687282996
                }
              ],
              "distance": 8,
              "postalCode": "10002",
              "cc": "US",
              "city": "New York",
              "state": "NY",
              "country": "United States",
              "formattedAddress": [
                "180 Orchard St (btwn Houston & Stanton St)",
                "New York, NY 10002",
                "United States"
              ]
            },
            "categories": [
              {
                "id": "4bf58dd8d48988d1d5941735",
                "name": "Hotel Bar",
                "pluralName": "Hotel Bars",
                "shortName": "Hotel Bar",
                "icon": {
                  "prefix": "https://ss3.4sqi.net/img/categories_v2/travel/hotel_bar_",
                  "suffix": ".png"
                },
                "primary": true
              }
            ],
            "venuePage": {
              "id": "150747252"
            }
        }
        """.data(using: .utf8) else { XCTFail(); return }

        do {
            let venue = try JSONDecoder().decode(Venue.self, from: jsonData)

            let expectedFormattedAddress = [
                "180 Orchard St (btwn Houston & Stanton St)",
                "New York, NY 10002",
                "United States"
            ]

            XCTAssertEqual(venue.id, "5642aef9498e51025cf4a7a5")
            XCTAssertEqual(venue.name, "Mr. Purple")
            XCTAssertEqual(venue.location.lat, 40.72173744277209)
            XCTAssertEqual(venue.location.lng, -73.98800687282996)
            XCTAssertEqual(venue.location.distance, 8)
            XCTAssertEqual(venue.location.formattedAddress, expectedFormattedAddress)
        } catch {
            XCTFail(String(describing: error))
        }
    }
}
