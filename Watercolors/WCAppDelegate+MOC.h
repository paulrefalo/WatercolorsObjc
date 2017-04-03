//
//  WCAppDelegate+MOC.h
//  KP_Acronyms
//
//  Created by Leisa Refalo on 1/30/14.
//  Copyright (c) 2014 Leisa Refalo. All rights reserved.
//

#import "WCAppDelegate.h"

@interface WCAppDelegate (MOC)
- (NSManagedObjectContext *)createMainQueueManagedObjectContext;
- (NSManagedObjectContext *)getManagedObjectContext;
- (void)saveContext;
- (void)saveContext:(NSManagedObjectContext *)managedObjectContext;
@end
