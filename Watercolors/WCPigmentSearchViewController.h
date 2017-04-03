//
//  WCPigmentViewController.h
//  Watercolors
//
//  Created by Leisa on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//
#import "CoreDataTableViewController.h"
#import <UIKit/UIKit.h>

@interface WCPigmentSearchViewController : CoreDataTableViewController  <UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSArray *filteredTableData;
    
}


@property (strong, nonatomic) NSFetchRequest *searchFetchRequest;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSString *searchString;

@property (weak, nonatomic) IBOutlet UISearchBar *theSearchBar;

@end
