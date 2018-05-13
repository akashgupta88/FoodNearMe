//
//  VenueListInteractorSpec.swift
//  FoodNearMeTests
//
//  Created by Akash Gupta on 10/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import XCTest
@testable import FoodNearMe
import CoreLocation

private class MockInteractorOutput: VenueListInteractorOutput {

    var venuesFetched: [Venue]?
    var venuesFailedError: String?
    var filteredVenueList: [Venue]?

    func venueListFetched(_ venues: [Venue]) {
        venuesFetched = venues
    }

    func venueListFetchFailed(error: String?) {
        venuesFailedError = error
    }

    func venueListFiltered(_ venues: [Venue]) {
        filteredVenueList = venues
    }
}

class MockFourSquareConnection: FourSquareConnection {
    var fetchFail = false
    var fetchFoodVenuesCalled = false
    var fetchFoodLatitude: Double?
    var fetchFoodLongitude: Double?

    func fetchFoodVenues(lat: Double, lon: Double, success: @escaping ([Venue]) -> Void, failure: @escaping     (Error) -> Void) {
        fetchFoodVenuesCalled = true
        fetchFoodLatitude = lat
        fetchFoodLongitude = lon
        if fetchFail {
            failure(NSError(domain: "com.foodnearme.test", code: 0, userInfo: nil))
        } else {
            success([Venue(id: "someId",
                           name: "someName",
                           location: VenueLocation(formattedAddress: [],
                                                   lat: lat,
                                                   lng: lon,
                                                   distance: 0))])
        }
    }
}

class MockLocationFetcher: LocationFetcher {
    var locationFail = false
    var locationFetchCalled = false

    func getCurrentLocation(handler: @escaping LocationHandler) {
        locationFetchCalled = true
        if locationFail {
            handler(.error(.otherError))
        } else {
            handler(.location(CLLocation(latitude: 123.4, longitude: 567.8)))
        }
    }
}

class MockDataManager: VenueListDataProvider {

    var dataStore: VenueDataStore?

    var getDislikedVenueIdsCalled = false

    func getDislikedVenueIds(handler: @escaping ([String]) -> Void) {
        getDislikedVenueIdsCalled = true
        handler(["someOtherId"])
    }
}

class VenueListInteractorSpec: XCTestCase {

    var interactor: VenueListInteractor!
    var connection: MockFourSquareConnection!
    var locationFetcher: MockLocationFetcher!
    var dataManager: MockDataManager!
    private var output: MockInteractorOutput!
    
    override func setUp() {
        super.setUp()

        connection = MockFourSquareConnection()
        locationFetcher = MockLocationFetcher()
        output = MockInteractorOutput()
        dataManager = MockDataManager()
        interactor = VenueListInteractor(connection: connection, locationFetcher: locationFetcher)
        interactor.output = output
        interactor.dataProvider = dataManager
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldFetchFoodVenues() {
        interactor.fetchVenueList()

        XCTAssertTrue(locationFetcher.locationFetchCalled)
        XCTAssertTrue(connection.fetchFoodVenuesCalled)
        XCTAssertEqual(connection.fetchFoodLatitude, 123.4)
        XCTAssertEqual(connection.fetchFoodLongitude, 567.8)
        XCTAssertEqual(output.venuesFetched?.count, 1)
        XCTAssertNil(output.venuesFailedError)
    }

    func testShouldHandleLocationError() {
        locationFetcher.locationFail = true

        interactor.fetchVenueList()

        XCTAssertTrue(locationFetcher.locationFetchCalled)
        XCTAssertFalse(connection.fetchFoodVenuesCalled)
        XCTAssertNotNil(output.venuesFailedError)
        XCTAssertNil(output.venuesFetched)
    }

    func testShouldHandleConnectionError() {
        connection.fetchFail = true

        interactor.fetchVenueList()

        XCTAssertTrue(locationFetcher.locationFetchCalled)
        XCTAssertTrue(connection.fetchFoodVenuesCalled)
        XCTAssertNotNil(output.venuesFailedError)
        XCTAssertNil(output.venuesFetched)
    }

    func testShouldFilterDislikedVenueIds() {
        interactor.filterVenueList([Venue(id: "someId",
                                          name: "someName",
                                          location: VenueLocation(formattedAddress: [],
                                                                  lat: 123.4,
                                                                  lng: 567.8,
                                                                  distance: 0)),
                                    Venue(id: "someOtherId",
                                          name: "someOtherName",
                                          location: VenueLocation(formattedAddress: [],
                                                                  lat: 432.1,
                                                                  lng: 876.5,
                                                                  distance: 0))])

        XCTAssertTrue(dataManager.getDislikedVenueIdsCalled)
        XCTAssertEqual(output.filteredVenueList?.count, 1)
        XCTAssertEqual(output.filteredVenueList?.first?.id, "someId")
    }
}
