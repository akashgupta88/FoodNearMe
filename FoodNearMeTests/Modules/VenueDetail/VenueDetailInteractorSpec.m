//
//  VenueDetailInteractorSpec.m
//  FoodNearMeTests
//
//  Created by Akash Gupta on 12/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "VenueDetailContract.h"
#import "VenueDetailInteractor.h"
#import "FoodNearMe-Swift.h"

@interface VenueDetailInteractorSpec : XCTestCase

@property (strong, nonatomic) VenueDetailInteractor *interactor;
@property (strong, nonatomic) id dataProvider;

@end

@implementation VenueDetailInteractorSpec

- (void)setUp {
    [super setUp];

    _interactor = [VenueDetailInteractor new];
    _dataProvider = [OCMockObject mockForProtocol:@protocol(VenueDetailDataProvider)];
    _interactor.dataProvider = _dataProvider;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testShouldHandleDislikedVenue {

    id venue = [OCMockObject mockForClass:[Venue class]];

    [[_dataProvider expect] dislikeVenue:venue];

    [_interactor dislikeVenue:venue];

    [_dataProvider verify];
}

@end
