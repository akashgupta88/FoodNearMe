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

    func venueListFetched(_ venues: [Venue]) {
        venuesFetched = venues
    }

    func venueListFetchFailed(error: String?) {
        venuesFailedError = error
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

class VenueListInteractorSpec: XCTestCase {

    var interactor: VenueListInteractor!
    var connection: MockFourSquareConnection!
    var locationFetcher: MockLocationFetcher!
    private var output: MockInteractorOutput!
    
    override func setUp() {
        super.setUp()

        connection = MockFourSquareConnection()
        locationFetcher = MockLocationFetcher()
        output = MockInteractorOutput()
        interactor = VenueListInteractor(connection: connection, locationFetcher: locationFetcher)
        interactor.output = output
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
}
