//
//  VenueDetailViewController.m
//  FoodNearMe
//
//  Created by Akash Gupta on 11/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

#import "VenueDetailViewController.h"
#import "FoodNearMe-Swift.h"

@interface VenueDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *venueName;
@property (weak, nonatomic) IBOutlet UILabel *venueAddress;

@end

@implementation VenueDetailViewController

@synthesize presenter = _presenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [_presenter viewDidLoad];
}

-(void)showVenueDetail:(Venue *)venue {
    _venueName.text = venue.name;
    _venueAddress.text = [venue.location.formattedAddress componentsJoinedByString:@"\n"];
}

@end
