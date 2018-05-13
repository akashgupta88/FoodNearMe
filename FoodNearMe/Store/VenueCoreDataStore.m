//
//  CoreDataStore.m
//  FoodNearMe
//
//  Created by Akash Gupta on 13/05/18.
//  Copyright © 2018 Akash Gupta. All rights reserved.
//

#import "VenueCoreDataStore.h"
#import <CoreData/CoreData.h>
#import "DislikedVenue+CoreDataProperties.h"
#import "DislikedVenue+CoreDataClass.h"

@interface VenueCoreDataStore ()

@property (strong, readonly) NSPersistentContainer *persistentContainer;

@end

@implementation VenueCoreDataStore

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"FoodNearMe"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {

                    NSLog(@"Persistent Container error %@, %@", error, error.userInfo);
                }
            }];
        }
    }
    return _persistentContainer;
}

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Context save error %@, %@", error, error.userInfo);
    }
}


- (void)fetchDislikedVenuesWithHandler:(DislikedVenueFetchHandler)handler {

    NSFetchRequest *fetchRequest = [DislikedVenue fetchRequest];
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    [context performBlock:^{
        NSArray <DislikedVenue*> *results = [context executeFetchRequest:fetchRequest error: nil];

        NSMutableArray <NSString*> *venueIds = [NSMutableArray new];
        [results enumerateObjectsUsingBlock:^(DislikedVenue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [venueIds addObject:obj.venueId];
        }];

        if (handler)
        {
            handler(venueIds);
        }
    }];
}

- (DislikedVenue *)newDislikedVenue {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"DislikedVenue"
                                                         inManagedObjectContext:context];
    DislikedVenue *newEntry = (DislikedVenue *)[[NSManagedObject alloc] initWithEntity:entityDescription
                                                        insertIntoManagedObjectContext:context];
    return newEntry;
}

@end
