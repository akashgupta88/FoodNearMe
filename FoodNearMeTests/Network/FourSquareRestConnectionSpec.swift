//
//  FourSquareRestConnectionSpec.swift
//  FoodNearMeTests
//
//  Created by Akash Gupta on 08/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import Foundation
import XCTest
@testable import FoodNearMe

class MockRestConnection: RestConnection {
    var successResponse: Any?

    var getUrl: String?
    var getParams: [String: AnyHashable]?

    func get(url: String, parameters: [String : Any]?, success: @escaping (Any) -> Void, failure: @escaping (Error) -> Void) {
        getUrl = url
        getParams = parameters as? [String: AnyHashable]
        if let response = successResponse {
            success(response)
        } else {
            failure(NSError(domain: "com.foodnearmetest", code: 0, userInfo: nil))
        }
    }
}

class FourSquareRestConnectionSpec: XCTestCase {

    var mockRestConnection: MockRestConnection!
    var fourSquareConnection: FourSquareRestConnection!

    override func setUp() {
        mockRestConnection = MockRestConnection()
        fourSquareConnection = FourSquareRestConnection(restConnection: mockRestConnection)
    }

    func testShouldFetchVenuesForGivenLocation() {

        mockRestConnection.successResponse = [
            "meta": [
                "code": 200,
                "requestId": "5ac51d7e6a607143d811cecb"
            ],
            "response": [
                "venues": [
                    [
                        "id": "5642aef9498e51025cf4a7a5",
                        "name": "Mr. Purple",
                        "location": [
                            "lat": 40.72173744277209,
                            "lng": -73.98800687282996,
                            "distance": 8,
                            "formattedAddress": [
                                "180 Orchard St (btwn Houston & Stanton St)",
                                "New York, NY 10002",
                                "United States"
                            ]
                        ]
                    ],
                    [
                        "id": "5642aef9498e51025f31a9e7",
                        "name": "Shake Shack",
                        "location": [
                            "lat": 40.72173744279209,
                            "lng": -73.98800687282746,
                            "distance": 11,
                            "formattedAddress": [
                                "17 Bleeker St",
                                "New York, NY 10002",
                                "United States"
                            ]
                        ]
                    ]
                ]
            ]
        ]

        let expectation = self.expectation(description: "API should send successful response")
        expectation.expectedFulfillmentCount = 1

        var fetchedVenues: [Venue]?
        fourSquareConnection.fetchFoodVenues(lat: 123.45, lon: -765.43, success: { venues in
            fetchedVenues = venues
            expectation.fulfill()
        }, failure: { error in
            XCTFail(String(describing: error))
        })

        waitForExpectations(timeout: 0) { _ in

            let expectedParams: [String: AnyHashable] = [
                "ll": "123.45,-765.43",
                "client_id": "L1UYLAJCAD2LNEIS2TI0UBSVCZQ1BAGNBAQRROTLECH10OW3",
                "client_secret": "VCU2TPB4FN24A3GOPOTHDBC2XX2B5DYXQKNDLMKG2LSX1TH0",
                "v": "20180501",
                "categoryId": "4d4b7105d754a06374d81259"
            ]

            XCTAssertEqual(self.mockRestConnection.getUrl, "https://api.foursquare.com/v2/venues/search")
            XCTAssertEqual(self.mockRestConnection.getParams ?? [:], expectedParams)
            XCTAssertEqual(fetchedVenues?.count, 2)
        }
    }

    func testShouldHandleAPIError() {
        let expectation = self.expectation(description: "API should send failure response")
        expectation.expectedFulfillmentCount = 1

        fourSquareConnection.fetchFoodVenues(lat: 123.45, lon: -765.43, success: { venues in
            XCTFail("API Success called instead of failure")
        }, failure: { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        })

        waitForExpectations(timeout: 0)
    }
}
