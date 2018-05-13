//
//  VenueDetailPresenterSpec.m
//  FoodNearMeTests
//
//  Created by Akash Gupta on 12/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "VenueDetailPresenter.h"
#import "FoodNearMe-Swift.h"

@interface VenueDetailPresenterSpec : XCTestCase

@property (strong, nonatomic) VenueDetailPresenter *presenter;
@property (strong, nonatomic) id view;
@property (strong, nonatomic) id interactor;
@property (strong, nonatomic) id router;
@property (strong, nonatomic) Venue *venue;

@end

@implementation VenueDetailPresenterSpec

- (void)setUp {
    [super setUp];

    _presenter = [[VenueDetailPresenter alloc] init];
    _view = [OCMockObject mockForProtocol:@protocol(VenueDetailView)];
    _interactor = [OCMockObject mockForProtocol:@protocol(VenueDetailUseCase)];
    _router = [OCMockObject mockForProtocol:@protocol(VenueDetailWireFrame)];

    VenueLocation * location = [[VenueLocation alloc] initWithFormattedAddress:@[] lat:123.45 lng:678.9 distance:12.0];
    _venue = [[Venue alloc] initWithId:@"123" name:@"Some Venue" location:location];

    _presenter.view = _view;
    _presenter.venue = _venue;
    _presenter.interactor = _interactor;
    _presenter.router = _router;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testShouldPresentVenueDetail {

    [[_view expect] showVenueDetail:_venue];

    [_presenter viewDidLoad];

    [_view verify];
}

-(void)testShouldHandleDislikeVenue {

    [[_interactor expect] dislikeVenue:_venue];
    [[_router expect] routeToVenueList];

    [_presenter dislikeTapped];

    [_interactor verify];
    [_router verify];
}


@end
