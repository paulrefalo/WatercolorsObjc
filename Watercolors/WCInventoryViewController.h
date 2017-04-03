//
//  WCSearchViewController.h
//  Watercolors
//
//  Created by Leisa on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import <UIKit/UIKit.h>
#import "WCAppDelegate.h"
#import "WCAppDelegate+MOC.h"

@interface WCInventoryViewController : CoreDataTableViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *inventorySegmentedControl;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) WCAppDelegate *appdelegate;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;


@property (nonatomic, retain) NSFetchedResultsController *haveFetchedResultsController;
@property (nonatomic, retain) NSFetchedResultsController *needFetchedResultsController;
@property (nonatomic, retain) NSFetchedResultsController *allFetchedResultsController;


@end
