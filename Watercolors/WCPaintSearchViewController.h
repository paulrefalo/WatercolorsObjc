//
//  WCPaintSearchViewController.h
//  Watercolors
//
//  Created by Leisa Refalo on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//
#import "CoreDataTableViewController.h"
#import <UIKit/UIKit.h>

@interface WCPaintSearchViewController : CoreDataTableViewController  <UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSArray *fetchedObjects;
    
}


@property (strong, nonatomic) NSFetchRequest *searchFetchRequest;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSString *searchString;

@property (weak, nonatomic) IBOutlet UISearchBar *theSearchBar;

@end
