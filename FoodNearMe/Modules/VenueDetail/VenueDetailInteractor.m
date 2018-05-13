//
//  VenueDetailInteractor.m
//  FoodNearMe
//
//  Created by Akash Gupta on 11/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

#import "VenueDetailInteractor.h"

@implementation VenueDetailInteractor

@synthesize output = _output, dataProvider = _dataProvider;

-(void)dislikeVenue:(Venue *)venue {
    [_dataProvider dislikeVenue:venue];
}

@end
