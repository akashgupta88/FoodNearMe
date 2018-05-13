//
//  VenueDetailContract.h
//  FoodNearMe
//
//  Created by Akash Gupta on 11/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@class Venue, UIViewController;
@protocol VenueDetailPresentation, VenueDetailUseCase, VenueDetailInteractorOutput, VenueDetailWireFrame, VenueDetailDataProvider;
@protocol VenueDataStore;

@protocol VenueDetailView <NSObject>

@property (strong, nonatomic) id <VenueDetailPresentation> presenter;

-(void) showVenueDetail:(Venue*)venue;

@end

@protocol VenueDetailPresentation <NSObject>

@property (strong, nonatomic) Venue *venue;
@property (weak, nonatomic) id <VenueDetailView> view;
@property (strong, nonatomic) id <VenueDetailWireFrame> router;
@property (strong, nonatomic) id <VenueDetailUseCase> interactor;

-(void) viewDidLoad;

- (void) dislikeTapped;

@end

@protocol VenueDetailUseCase <NSObject>

@property (weak, nonatomic) id <VenueDetailInteractorOutput> output;
@property (strong, nonatomic) id <VenueDetailDataProvider> dataProvider;

- (void) dislikeVenue: (Venue*)venue;

@end

@protocol VenueDetailInteractorOutput <NSObject>

@end

@protocol VenueDetailWireFrame <NSObject>

@property (weak, nonatomic) UIViewController *viewController;

+(UIViewController*)assembleModuleWithVenue:(Venue*)venue;

-(void) routeToVenueList;

@end

@protocol VenueDetailDataProvider <NSObject>

@property (strong, nonatomic) id <VenueDataStore> dataStore;

-(void)dislikeVenue:(Venue*)venue;

@end

NS_ASSUME_NONNULL_END

