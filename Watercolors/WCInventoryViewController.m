//
//  WCSearchViewController.m
//  Watercolors
//
//  Created by Leisa on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "WCInventoryViewController.h"
#import "WCPaintDetailTableViewController.h"
#import "Paint.h"


@interface WCInventoryViewController ()


- (IBAction)inventoryControlPressed:(id)sender;

@end

@implementation WCInventoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.appdelegate = (WCAppDelegate*)[[UIApplication sharedApplication] delegate];
    [self setManagedObjectContext:self.appdelegate.managedObjectContext];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshData:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:nil];
    
    
    
    // we want fresh data
    [self.managedObjectContext setStalenessInterval:0];
    [self.tableView reloadData];
    
    // set the defaul segmented control setting (all unless previously set)
    
}

- (void) refreshData:(NSNotification *)notif {
    
    
    //listen for saves
   [self setTheFilterPredicate];
    [self fetchedResultsController];
//    [[[self fetchedResultsController] managedObjectContext] mergeChangesFromContextDidSaveNotification:notif];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



 


 #pragma mark - TableView
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
 
 static NSString *CellIdentifier = @"SearchForPaintCell";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 // Configure the cell...
 
 Paint *this_paint = [self.fetchedResultsController objectAtIndexPath:indexPath];
 
     
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
 
     // 35 Have
     
     UIImageView *haveImageView = (UIImageView *)[cell.contentView viewWithTag:35];
     
     
      if (this_paint.have.boolValue == YES){
 
         haveImageView.image = [UIImage imageNamed:@"Have"];
     } else {
         haveImageView.image = [UIImage imageNamed:@"Have-Not"];
     }
    
     
 
     
     // 45 Need
     UIImageView *needImageView = (UIImageView *)[cell.contentView viewWithTag:45];
  
        if (this_paint.need.boolValue == YES){
         needImageView.image = [UIImage imageNamed:@"Need"];
     } else {
         needImageView.image = [UIImage imageNamed:@"Need-Not"];
     }
 
 return cell;
 }


 #pragma mark - Core Data
 - (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
 {
 
 
 _managedObjectContext = managedObjectContext;
 
 NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Paint"];
    [self setTheFilterPredicate];
     request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"paint_name"
                                                               ascending:YES
                                                                selector:@selector(localizedStandardCompare:)]];

     
     switch (self.inventorySegmentedControl.selectedSegmentIndex) {
         case 0:
             self.fetchedResultsController = self.allFetchedResultsController;
             break;
         case 1:
             self.fetchedResultsController = self.needFetchedResultsController;
             break;
         case 2:
             self.fetchedResultsController = self.allFetchedResultsController;
             break;
         default:
             break;
             
     }
     [self.tableView reloadData];
     

 
     
     self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                         managedObjectContext:managedObjectContext
                                                                           sectionNameKeyPath:nil
                                                                                    cacheName:nil];
     
  [self.tableView reloadData];
 
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

-(void)setTheFilterPredicate {
    
    NSPredicate *predicate = nil;

    
    switch (self.inventorySegmentedControl.selectedSegmentIndex) {
        case 0: // Have
            predicate = [NSPredicate predicateWithFormat:@"have = '1'"];
            break;
        case 1: // Need
            predicate = [NSPredicate predicateWithFormat:@"want = '1'"];
            break;
        case 2: // All
            break;
        default:
            break;
            
    }
      [self.fetchedResultsController.fetchRequest setPredicate:predicate];
}

- (IBAction)inventoryControlPressed:(id)sender {
    // fetch list based on which was set
    

    [self setTheFilterPredicate];
   
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {

    switch (self.inventorySegmentedControl.selectedSegmentIndex) {
        case 0:
            self.fetchedResultsController = self.haveFetchedResultsController;
            break;
        case 1:
            self.fetchedResultsController = self.needFetchedResultsController;
            break;
        case 2:
            self.fetchedResultsController = self.allFetchedResultsController;
            break;
        default:
            break;
            
    }
    }
    [self.tableView reloadData];
    
}

- (NSFetchedResultsController *)haveFetchedResultsController
{
    if (_haveFetchedResultsController != nil) {
        return _haveFetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Paint" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"paint_name" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"have = '1'"];
    [fetchRequest setPredicate:predicate];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    self.haveFetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.haveFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    

    [self.tableView reloadData];


    return _haveFetchedResultsController;
}


- (NSFetchedResultsController *)needFetchedResultsController
{
    if (_needFetchedResultsController != nil) {
        return _needFetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Paint" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"paint_name" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"need = '1'"];
    [fetchRequest setPredicate:predicate];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    self.needFetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.needFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _needFetchedResultsController;
}


- (NSFetchedResultsController *)allFetchedResultsController
{
    if (_allFetchedResultsController != nil) {
        return _allFetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Paint" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"paint_name" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];

    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    self.allFetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.allFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _allFetchedResultsController;

}


@end
