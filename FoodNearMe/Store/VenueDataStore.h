//
//  VenueDataStore.h
//  FoodNearMe
//
//  Created by Akash Gupta on 13/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

@class Venue;

NS_ASSUME_NONNULL_BEGIN

typedef void(^DislikedVenueFetchHandler)(NSArray <NSString*> *venueIds);

@protocol VenueDataStore <NSObject>

- (void)fetchDislikedVenuesWithHandler:(DislikedVenueFetchHandler)handler;

- (void)saveDislikedVenueWithID:(NSString*)venueId;

@end

NS_ASSUME_NONNULL_END
