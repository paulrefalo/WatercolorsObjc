//
//  FamilyTableViewController.h
//  Watercolors
//
//  Created by Leisa on 4/16/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import <UIKit/UIKit.h>
#import "WCAppDelegate.h"
#import "WCAppDelegate+MOC.h"

@interface FamilyTableViewController : CoreDataTableViewController
@property (strong, nonatomic) NSString * title_str;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) WCAppDelegate *appdelegate;

@end







