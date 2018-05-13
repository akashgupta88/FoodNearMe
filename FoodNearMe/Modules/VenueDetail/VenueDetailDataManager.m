//
//  VenueDetailDataManager.m
//  FoodNearMe
//
//  Created by Akash Gupta on 13/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

#import "VenueDetailDataManager.h"
#import "VenueCoreDataStore.h"
#import "DislikedVenue+CoreDataProperties.h"
#import "FoodNearMe-Swift.h"

@implementation VenueDetailDataManager

@synthesize dataStore =_dataStore;

- (void)dislikeVenue:(nonnull Venue *)venue {
    [_dataStore saveDislikedVenueWithID:venue.id];
}

@end
