//
//  VenueListPresenterSpec.swift
//  FoodNearMeTests
//
//  Created by Akash Gupta on 10/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

import XCTest
@testable import FoodNearMe

private class MockInteractor: VenueListUseCase {
    var dataProvider: VenueListDataProvider?

    var output: VenueListInteractorOutput?
    
    var fetchVenueListCalled = false
    var failFetch = false
    var venueListToFilter: [Venue]?
    
    func fetchVenueList() {
        fetchVenueListCalled = true
        
        if failFetch {
            output?.venueListFetchFailed(error: "Some Error")
        } else {
            output?.venueListFetched([Venue(id: "someId",
                                            name: "someName",
                                            location: VenueLocation(formattedAddress: [],
                                                                    lat: 123.4,
                                                                    lng: 567.8,
                                                                    distance: 0))])
        }
    }

    func filterVenueList(_ venues: [Venue]) {
        venueListToFilter = venues
        output?.venueListFiltered(venues)
    }
}

private class MockRouter: VenueListWireFrame {
    var viewController: UIViewController?
    
    var venueDetailToPresent: Venue?
    var alertToPresent: (title: String, message: String, actionTitle: String?, action: (() -> Void)?)?
    
    func presentVenueDetail(_ venue: Venue) {
        venueDetailToPresent = venue
    }
    
    func presentAlert(title: String, message: String, actionTitle: String?, action:(() -> Void)?) {
        alertToPresent = (title: title, message: message, actionTitle: actionTitle, action: action)
    }
    
    static func assembleModule() -> UIViewController {
        return UIViewController()
    }
}

private class MockView: VenueListView {
    var presenter: VenueListPresentation?
    
    var showNoVenueFoundMessageCalled = false
    var venueListToShow: VenueListViewModel?
    
    func showNoVenueFoundMessage() {
        showNoVenueFoundMessageCalled = true
    }
    
    func showVenueList(_ viewModel: VenueListViewModel) {
        venueListToShow = viewModel
    }
}

class VenueListPresenterSpec: XCTestCase {
    
    var presenter: VenueListPresenter!
    
    private var interactor: MockInteractor!
    private var router: MockRouter!
    private var view: MockView!
    
    override func setUp() {
        super.setUp()
        
        interactor = MockInteractor()
        router = MockRouter()
        view = MockView()
        presenter = VenueListPresenter(router: router, interactor: interactor)
        interactor.output = presenter
        presenter.view = view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShouldFetchFoodVenuesOnViewLoad() {
        presenter.viewDidLoad()

        XCTAssertTrue(interactor.fetchVenueListCalled)
        XCTAssertEqual(interactor.venueListToFilter?.count, 1)
        XCTAssertEqual(view.venueListToShow?.count, 1)
    }
    
    func testShouldHandleFetchVenueFail() {
        interactor.failFetch = true
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(interactor.fetchVenueListCalled)
        XCTAssertNil(view.venueListToShow)
        XCTAssertTrue(view.showNoVenueFoundMessageCalled)
        XCTAssertEqual(router.alertToPresent?.title, "Uh Oh")
        XCTAssertEqual(router.alertToPresent?.message, "Some Error")
        XCTAssertEqual(router.alertToPresent?.actionTitle, "Retry")
        XCTAssertTrue(router.alertToPresent?.action != nil)
    }
    
    func testShouldHandleVenueSelection() {
        presenter.viewDidLoad()
        presenter.didSelectVenue(index: 0)
        
        XCTAssertNotNil(router.venueDetailToPresent)
    }

    func testShouldFilterVenueListOnViewAppear() {
        presenter.venues = [Venue(id: "someId",
                                  name: "someName",
                                  location: VenueLocation(formattedAddress: [],
                                                          lat: 123.4,
                                                          lng: 567.8,
                                                          distance: 0))]
        presenter.viewWillAppear()

        XCTAssertEqual(interactor.venueListToFilter?.count, 1)
    }
}
