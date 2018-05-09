//
//  VenueListRouter.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 08/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import UIKit

class VenueListRouter: VenueListWireFrame {
    weak var viewController: UIViewController?

    func presentVenueDetail(_ venue: Venue) {

    }

    static func assembleModule() -> UIViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).createViewController(withIdentifier: "")
        return viewController
    }
}
