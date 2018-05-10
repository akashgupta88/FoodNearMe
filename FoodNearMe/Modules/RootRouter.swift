//
//  RootRouter.swift
//  FoodNearMe
//
//  Created by Akash Gupta on 10/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import UIKit

protocol RootWireframe: class {
    func presentVenueListScreen(in window: UIWindow)
}

class RootRouter: NSObject, RootWireframe {

    @objc func presentVenueListScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: VenueListRouter.assembleModule())
    }
}
