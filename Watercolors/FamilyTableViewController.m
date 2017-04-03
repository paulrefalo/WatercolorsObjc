//
//  FamilyTableViewController.m
//  Watercolors
//
//  Created by Leisa on 4/16/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "FamilyTableViewController.h"
#include "Paint.h"
#include "WCPaintDetailTableViewController.h"

@interface FamilyTableViewController ()

@end

@implementation FamilyTableViewController
@synthesize title_str;


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
    
    self.title = self.title_str;
    
}

- (void) refreshData:(NSNotification *)notif {
    //listen for saves
    [[[self fetchedResultsController] managedObjectContext] mergeChangesFromContextDidSaveNotification:notif];
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
    
    
    static NSString *CellIdentifier = @"PaintColorCell";
    
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
    
    // NSLog(@"paintImageName: %@", this_paint.paint_name);
    // 20 Title
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:20];
    [label setText:[NSString stringWithFormat:@"%@", this_paint.paint_name]];
    
    // 30 LightFast
    label = (UILabel *)[cell.contentView viewWithTag:30];
    [label setText:[NSString stringWithFormat:@"%@", this_paint.lightfast_rating]];
    
    // 40 Opacity - staining_granulating - Temperature
   // NSString *compountStr = [NSString stringWithFormat:@"%@ - %@ - %@", this_paint.opacity, this_paint.staining_granulating, this_paint.temperature];
    NSString *compountStr = [NSString stringWithFormat:@"%@ - %@", this_paint.opacity, this_paint.staining_granulating];
    label = (UILabel *)[cell.contentView viewWithTag:40];
    [label setText:compountStr];

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
    
    // only thing we are doing is selecting only the acronyms with favorite set to yes
    
    _managedObjectContext = managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Paint"];
    request.predicate = nil;
    request.predicate =  [NSPredicate predicateWithFormat:@"color_family CONTAINS %@", self.title_str];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"sort_order"
                                                              ascending:YES
                                                               selector:@selector(localizedStandardCompare:)]];
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    
    
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


