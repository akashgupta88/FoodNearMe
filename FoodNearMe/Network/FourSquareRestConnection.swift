//
//  FourSquareRestConnection.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 08/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import Foundation
import Alamofire

@objc protocol FourSquareConnection {
    func fetchFoodVenues(lat: Double, lon: Double, success: @escaping ([Venue]) -> Void, failure: @escaping (Error) -> Void)
}

class FourSquareRestConnection: NSObject, FourSquareConnection {

    let restConnection: RestConnection

    init(restConnection: RestConnection) {
        self.restConnection = restConnection
    }

    func fetchFoodVenues(lat: Double, lon: Double, success: @escaping ([Venue]) -> Void, failure: @escaping (Error) -> Void) {

        let parameters: Parameters = [
            "ll": "\(lat),\(lon)",
            "clientId": "L1UYLAJCAD2LNEIS2TI0UBSVCZQ1BAGNBAQRROTLECH10OW3",
            "clientSecret": "VCU2TPB4FN24A3GOPOTHDBC2XX2B5DYXQKNDLMKG2LSX1TH0",
            "v": "20180501",
            "categoryId": "4d4b7105d754a06374d81259"
        ]

        restConnection.get(url: "https://api.foursquare.com/v2/venues/search", parameters: parameters, success: { response in
            guard let dict = response as? [String: Any],
                let responseDict = dict["response"] as?[String: Any],
                let venueDicts = responseDict["venues"] as? [[String: Any]] else {
                    failure(NSError(domain: "com.foodnearme", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response structure"]))

                    return
            }

            do {
                let data = try JSONSerialization.data(withJSONObject: venueDicts, options: [])
                let venues = try JSONDecoder().decode([Venue].self, from: data)
                success(venues)
            } catch {
                failure(error)
            }
        }, failure: failure)
    }
}
