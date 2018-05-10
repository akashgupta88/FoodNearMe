//
//  VenueDetailPresenter.m
//  FoodNearMe
//
//  Created by Akash Gupta on 11/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

#import "VenueDetailPresenter.h"

@implementation VenueDetailPresenter

@synthesize venue = _venue, view = _view, router = _router, interactor = _interactor;

- (void)viewDidLoad {
    [_view showVenueDetail: _venue];
}

@end
