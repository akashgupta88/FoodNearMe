//
//  VenueDetailRouter.m
//  FoodNearMe
//
//  Created by Akash Gupta on 11/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

#import "VenueDetailRouter.h"
#import "VenueDetailViewController.h"
#import "VenueDetailPresenter.h"
#import "VenueDetailInteractor.h"
#import "VenueDetailDataManager.h"
#import "VenueCoreDataStore.h"

@implementation VenueDetailRouter

@synthesize viewController = _viewController;

+(UIViewController*)assembleModuleWithVenue:(Venue*)venue {
    VenueDetailPresenter *presenter = [VenueDetailPresenter new];
    VenueDetailInteractor *interactor = [VenueDetailInteractor new];
    VenueDetailRouter *router = [VenueDetailRouter new];
    VenueDetailDataManager *dataManager = [VenueDetailDataManager alloc];
    dataManager.dataStore = [VenueCoreDataStore new];

    presenter.router = router;
    presenter.interactor = interactor;
    presenter.venue = venue;
    interactor.output = presenter;
    interactor.dataProvider = dataManager;

    VenueDetailViewController *viewController = [[UIStoryboard storyboardWithName:@"VenueDetail" bundle:nil] instantiateViewControllerWithIdentifier:@"VenueDetail"];
    viewController.presenter = presenter;
    presenter.view = viewController;
    router.viewController = viewController;

    return viewController;
}

-(void) routeToVenueList {
    [[_viewController navigationController] popViewControllerAnimated:YES];
}

@end
