//
//  VenueListRouterSpec.swift
//  FoodNearMeTests
//
//  Created by Akash Gupta on 10/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import XCTest
@testable import FoodNearMe

class MockViewController: UIViewController {

    var viewControllerToPresent: UIViewController?

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self.viewControllerToPresent = viewControllerToPresent
    }
}

class VenueListRouterSpec: XCTestCase {

    var router: VenueListRouter!
    var viewController: MockViewController!

    override func setUp() {
        super.setUp()

        viewController = MockViewController()
        router = VenueListRouter()
        router.viewController = viewController
    }

    func testShouldAssembleModule() {

        guard let viewController = VenueListRouter.assembleModule() as? VenueListViewController else {
            XCTFail(); return
        }

        XCTAssertNotNil(viewController.presenter is VenueListPresenter)
        XCTAssertTrue(viewController.presenter?.view === viewController)
        XCTAssertTrue(viewController.presenter?.interactor is VenueListInteractor)
        XCTAssertTrue(viewController.presenter?.router is VenueListRouter)
        XCTAssertTrue(viewController.presenter?.interactor.output === viewController.presenter)
        XCTAssertEqual(viewController.presenter?.router.viewController, viewController)
    }
    
    func testShouldPresentAlert() {
        router.presentAlert(title: "Some Title", message: "Some Message", actionTitle: "Action", action: {})

        guard let alert = viewController.viewControllerToPresent as? UIAlertController else {
            XCTFail(); return
        }
        XCTAssertEqual(alert.title, "Some Title")
        XCTAssertEqual(alert.title, "Some Title")
        XCTAssertEqual(alert.actions.first?.title, "Action")
    }
    
}
