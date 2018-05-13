//
//  VendeDetailDataManagerSpec.m
//  FoodNearMeTests
//
//  Created by Akash Gupta on 13/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "VenueDetailDataManager.h"
#import "VenueDataStore.h"
#import "VenueDetailContract.h"
#import "FoodNearMe-Swift.h"

@interface VendeDetailDataManagerSpec : XCTestCase

@property (strong, nonatomic) VenueDetailDataManager *dataManager;
@property (strong, nonatomic) id dataStore;

@end

@implementation VendeDetailDataManagerSpec

- (void)setUp {
    [super setUp];

    _dataStore = [OCMockObject mockForProtocol:@protocol(VenueDataStore)];
    _dataManager = [VenueDetailDataManager new];
    _dataManager.dataStore = _dataStore;
}

- (void)tearDown {
    [super tearDown];
}

-(void)testShouldSaveDislikedVenue {

    VenueLocation * location = [[VenueLocation alloc] initWithFormattedAddress:@[] lat:123.45 lng:678.9 distance:12.0];
    Venue *venue = [[Venue alloc] initWithId:@"123" name:@"Some Venue" location:location];

    [[_dataStore expect] saveDislikedVenueWithID:
     @"123"];

    [_dataManager dislikeVenue:venue];

    [_dataStore verify];
}

@end
