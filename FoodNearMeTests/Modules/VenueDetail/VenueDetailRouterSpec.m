//
//  VenueDetailRouterSpec.m
//  FoodNearMeTests
//
//  Created by Akash Gupta on 12/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FoodNearMe-Swift.h"
#import "VenueDetailRouter.h"
#import "VenueDetailViewController.h"
#import "VenueDetailPresenter.h"
#import "VenueDetailInteractor.h"
#import "VenueDetailDataManager.h"
#import "VenueCoreDataStore.h"

@interface VenueDetailRouterSpec : XCTestCase

@end

@implementation VenueDetailRouterSpec

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testShouldAssembleModule {

    VenueLocation * location = [[VenueLocation alloc] initWithFormattedAddress:@[] lat:123.45 lng:678.9 distance:12.0];
    Venue *venue = [[Venue alloc] initWithId:@"123" name:@"Some Venue" location:location];

    VenueDetailViewController *viewController = (VenueDetailViewController*)[VenueDetailRouter assembleModuleWithVenue:venue];

    XCTAssertTrue([viewController isKindOfClass: [VenueDetailViewController class]]);
    XCTAssertTrue([viewController.presenter isKindOfClass:[VenueDetailPresenter class]]);
    XCTAssertTrue([viewController.presenter.view isEqual:viewController]);
    XCTAssertTrue([viewController.presenter.router isKindOfClass:[VenueDetailRouter class]]);
    XCTAssertTrue([viewController.presenter.router.viewController isEqual: viewController]);
    XCTAssertTrue([viewController.presenter.interactor isKindOfClass:[VenueDetailInteractor class]]);
    XCTAssertTrue([viewController.presenter.interactor.output isEqual:viewController.presenter]);
    XCTAssertTrue([viewController.presenter.venue isEqual:venue]);
    XCTAssertTrue([viewController.presenter.interactor.dataProvider isKindOfClass:[VenueDetailDataManager class]]);
    XCTAssertTrue([viewController.presenter.interactor.dataProvider.dataStore isKindOfClass:[VenueCoreDataStore class]]);
}

@end
