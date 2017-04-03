//
//  WCPaintSearchViewController.m
//  Watercolors
//
//  Created by Leisa Refalo on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "WCPaintSearchViewController.h"
#import "WCPaintDetailTableViewController.h"
#import "Paint.h"
#import "WCAppDelegate.h"

@interface WCPaintSearchViewController ()

@end

@implementation WCPaintSearchViewController
@synthesize searchFetchRequest;

typedef enum
{
    searchScopePaint = 0,
    searchScopeNumber = 1,
    searchAll = 2
} PaintSearchScope;



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
      static NSString *CellIdentifier = @"SearchForPaintCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
       Paint *this_paint = nil;
    
    if (tableView == self.tableView)
    {
        this_paint = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }
    else
    {
        this_paint = [self.filteredList objectAtIndex:indexPath.row];
    }
    // Configure the cell...    
    
    // 10 Image
    NSNumber *paintNumb = this_paint.paint_number;
    NSString *paintImageName = [paintNumb stringValue];
    
    UIImageView *paintImageView = (UIImageView *)[cell.contentView viewWithTag:10];
    paintImageView.image = [UIImage imageNamed:paintImageName];
    
    //    firstCell.imageView.image = [UIImage imageNamed:@"ButtonFavoriteOn"];
    
    // NSLog(@"paintImageName: %@", this_paint.paint_name);
    // 20 Title
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:20];
    [label setText:[NSString stringWithFormat:@"%@", this_paint.paint_name]];
    
    // 30 LightFast
    label = (UILabel *)[cell.contentView viewWithTag:30];
    [label setText:[NSString stringWithFormat:@"%@", this_paint.lightfast_rating]];
    
    // 40 Opacity - staining_granulating - Temperature
    NSString *compountStr = [NSString stringWithFormat:@"%@ - %@ - %@", this_paint.opacity, this_paint.staining_granulating, this_paint.temperature];
    label = (UILabel *)[cell.contentView viewWithTag:40];
    [label setText:compountStr];
    
    return cell;
}


#pragma mark - Core Data
- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    
    //get all of the paints to show in the table.
    
    _managedObjectContext = managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Paint"];
    request.predicate = nil;
    //request.predicate =  [NSPredicate predicateWithFormat:@"favorite == %@", [NSNumber numberWithBool: YES]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"sort_order"
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Paint" inManagedObjectContext:self.managedObjectContext];
    [searchFetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sort_order" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [searchFetchRequest setSortDescriptors:sortDescriptors];
    
    return searchFetchRequest;
}

- (void)searchForText:(NSString *)searchText scope:(PaintSearchScope)scopeOption
{
    if (self.managedObjectContext)
    {
        NSString *predicateFormat = @"%K CONTAINS[cd] %@";
        NSString *searchAttribute = @"paint_name";
        
        if (scopeOption == searchScopePaint)
        {
            searchAttribute = @"paint_name";
        } else if (scopeOption == searchScopeNumber) {
            searchAttribute = @"paint_number";
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
    PaintSearchScope scopeKey = (int) controller.searchBar.selectedScopeButtonIndex;
    [self searchForText:searchString scope:scopeKey];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    NSString *searchString = controller.searchBar.text;
    [self searchForText:searchString scope:(PaintSearchScope)searchOption];
    
    return YES;
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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"prepareForSeque to DetailView");
    
    WCPaintDetailTableViewController *dvc = (WCPaintDetailTableViewController *)[segue destinationViewController];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    
    //  Pass the Acronym data object  to the destination view controller
    
    Paint *thisPaint = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    dvc.currentPaint = thisPaint;
}



@end
