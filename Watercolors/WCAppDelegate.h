//
//  WCAppDelegate.h
//  Watercolors
//
//  Created by Leisa Refalo on 4/15/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/* Core Data Objects */
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSURLConnection *connection;


@end
