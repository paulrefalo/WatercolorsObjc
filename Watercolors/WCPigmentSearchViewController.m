//
//  WCPigmentViewController.m
//  Watercolors
//
//  Created by Leisa on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "WCPigmentSearchViewController.h"
#import "Pigment.h"
#import "WCPigmentDetailTableViewController.h"
#import "WCAppDelegate.h"

@interface WCPigmentSearchViewController ()

@end

@implementation WCPigmentSearchViewController

@synthesize searchFetchRequest;
/*
typedef enum
{
    searchScopePigmentName = 0,
    searchScopePigmentCode = 1,
    searchAll = 2
} PigmentSearchScope;
*/


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.searchString = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

   WCAppDelegate *appdelegate = (WCAppDelegate*)[[UIApplication sharedApplication] delegate];
    [self setManagedObjectContext:appdelegate.managedObjectContext];
    
    // Listen to when MOC gets saved and refresh this table - calling refreshData function
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshData:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:nil];
    
    // we want fresh data
    [self.managedObjectContext setStalenessInterval:0];
    
   
    self.theSearchBar.delegate = (id)self;
    
    [self filter:@""];
    
}

- (void) refreshData:(NSNotification *)notif {
    //listen for saves
    [[[self fetchedResultsController] managedObjectContext] mergeChangesFromContextDidSaveNotification:notif];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    self.searchFetchRequest = nil;
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"SearchForPigmentCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    
     Pigment *this_pigment = [filteredTableData objectAtIndex:indexPath.row];

        // Configure the cell...
       
    // 10 Image
   
    UIImageView *pigmentImageView = (UIImageView *)[cell.contentView viewWithTag:10];
    pigmentImageView.image = [UIImage imageNamed:this_pigment.image_name];
    
    NSLog(@"image_name: %@", this_pigment.image_name);
    
    // 20 Title
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:20];
    [label setText:[NSString stringWithFormat:@"%@", this_pigment.pigment_code]];
    
    // 30 LightFast
    label = (UILabel *)[cell.contentView viewWithTag:30];
    [label setText:[NSString stringWithFormat:@"%@", this_pigment.pigment_words]];
    
    // 40 Opacity - staining_granulating - Temperature
    label = (UILabel *)[cell.contentView viewWithTag:40];
    [label setText:[NSString stringWithFormat:@"%@", this_pigment.chemical_name]];
    
    
    return cell;
}


#pragma mark - Core Data
- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    
    //get all of the pigments to show in the table.
    
    _managedObjectContext = managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pigment"];
    request.predicate = nil;
    //request.predicate =  [NSPredicate predicateWithFormat:@"favorite == %@", [NSNumber numberWithBool: YES]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"pigment_name"
                                                              ascending:YES
                                                               selector:@selector(localizedStandardCompare:)]];
    
    
    if (self.searchString)
    {
        
        if (![self.searchString isEqualToString:@""] ) {
            request.predicate = [NSPredicate predicateWithFormat:
                                 @"ANY symbols.name CONTAINS[cd] %@", self.searchString];
        }
    }
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                         
                                                                                   cacheName:nil];
    
}
/*

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // get the table and search bar bounds
       CGRect tableBounds = self.tableView.bounds;
    CGRect searchBarFrame = self.theSearchBar.frame;
    
    // make sure the search bar stays at the table's original x and y as the content moves
         self.theSearchBar.frame = CGRectMake(tableBounds.origin.x,
                                           tableBounds.origin.y,
                                          searchBarFrame.size.width,
                                           searchBarFrame.size.height);
}


    
- (NSFetchRequest *)searchFetchRequest
{
    if (searchFetchRequest != nil)
    {
        return searchFetchRequest;
}

    searchFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pigment" inManagedObjectContext:self.managedObjectContext];
    [searchFetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pigment_name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [searchFetchRequest setSortDescriptors:sortDescriptors];
    
    return searchFetchRequest;
}

- (void)searchForText:(NSString *)searchText scope:(PigmentSearchScope)scopeOption
{
    if (self.managedObjectContext)
    {
        NSString *predicateFormat = @"%K CONTAINS[cd] %@";
        NSString *searchAttribute = @"pigment_name";
        
        if (scopeOption == searchScopePigmentName)
        {
            searchAttribute = @"pigment_name";
        } else if (scopeOption == searchScopePigmentCode) {
            searchAttribute = @"pigment_code";
        } else {
            searchAttribute =nil;
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat, searchAttribute, searchText];
        [self.searchFetchRequest setPredicate:predicate];
        
        NSError *error = nil;
        self.filteredList = [self.managedObjectContext executeFetchRequest:self.searchFetchRequest error:&error];
    }
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    PigmentSearchScope scopeKey = (int) controller.searchBar.selectedScopeButtonIndex;
    [self searchForText:searchString scope:scopeKey];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    NSString *searchString = controller.searchBar.text;
    [self searchForText:searchString scope:(PigmentSearchScope)searchOption];
    
    return YES;
}*/

-(void)filter:(NSString*)searchText
{
    filteredTableData = [[NSMutableArray alloc] init];
    
    // Create our fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Define the entity we are looking for
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Pigment" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Define how we want our entities to be sorted
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"pigment_name" ascending:YES];
    NSArray* sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // If we are searching for anything...
    if([searchText length] > 0)
    {
        // Define how we want our entities to be filtered
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(pigment_name CONTAINS[c] %@) OR (alternative_names CONTAINS[c] %@)", searchText, searchText];
        [fetchRequest setPredicate:predicate];
    }
    
    NSError *error;
    
    // Finally, perform the load
    NSArray* loadedEntities = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    filteredTableData = [[NSMutableArray alloc] initWithArray:loadedEntities];
    
    [self.tableView reloadData];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = 80;
}


//*******************************************************************************************************************
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 75.f;
    
    
    return cellHeight;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount = (int)filteredTableData.count;
    return rowCount;
}



-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    [self filter:text];
    self.searchString = text;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void):(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"prepareForSeque to DetailView");
    
    WCPigmentDetailTableViewController *dvc = (WCPigmentDetailTableViewController *)[segue destinationViewController];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    
    //  Pass the Acronym data object  to the destination view controller
    
     Pigment *this_pigment = [filteredTableData objectAtIndex:indexPath.row];
    
    dvc.currentPigment = this_pigment;
}



@end
