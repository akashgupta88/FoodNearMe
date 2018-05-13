//
//  VenueListDataManagerSpec.swift
//  FoodNearMeTests
//
//  Created by Akash Gupta on 14/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import XCTest
@testable import FoodNearMe

class MockVenueDataStore: NSObject, VenueDataStore {

    var fetchDislikedVenuesCalled = false

    func fetchDislikedVenues(handler: @escaping DislikedVenueFetchHandler) {
        fetchDislikedVenuesCalled = true
        handler(["1234"])
    }

    func saveDislikedVenue(withID venueId: String) {

    }
}

class VenueListDataManagerSpec: XCTestCase {

    var dataManager: VenueListDataManager!
    var dataStore: MockVenueDataStore!

    override func setUp() {
        super.setUp()

        dataStore = MockVenueDataStore()
        dataManager = VenueListDataManager()
        dataManager.dataStore = dataStore
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testShouldFetchDislikedVenuesFromDataStore() {
        var venueIds: [String]?
        dataManager.getDislikedVenueIds { ids in
            venueIds = ids
        }

        XCTAssertTrue(dataStore.fetchDislikedVenuesCalled)
        XCTAssertEqual(venueIds?.count, 1)
        XCTAssertEqual(venueIds?.first, "1234")
    }

}
