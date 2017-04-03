//
//  WCDetailTableViewController.m
//  Watercolors
//
//  Created by Leisa on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "WCPaintDetailTableViewController.h"
#import "WCPigmentDetailTableViewController.h"

@interface WCPaintDetailTableViewController ()

@end

@implementation WCPaintDetailTableViewController
@synthesize currentPaint;
@synthesize lightFastLabel;
@synthesize opacityLabel;
@synthesize stainingLabel;

@synthesize paintImageView;
@synthesize titleLabel;
@synthesize haveImageView;
@synthesize needImageView;
@synthesize haveUISwitch;
@synthesize needUISwitch;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appdelegate = (WCAppDelegate*)[[UIApplication sharedApplication] delegate];
    [self setManagedObjectContext:self.appdelegate.managedObjectContext];
    
    NSNumber *paintNumb = currentPaint.paint_number;
    NSString *paintImageName = [paintNumb stringValue];
    paintImageView.image = [UIImage imageNamed:paintImageName];
     self.pigments = [self.currentPaint.contains allObjects];


    lightFastLabel.text = currentPaint.lightfast_rating;
    opacityLabel.text = currentPaint.opacity;
    stainingLabel.text = currentPaint.staining_granulating;
  //  pigmentCompositionLabel.text = currentPaint.pigment_composition;
    
  //  otherNamesLabel.text = currentPaint.other_names;
    
     titleLabel.text =  currentPaint.paint_name;
    
 //   paintImageView2.image = [UIImage imageNamed:paintImageName];
    
    // set up have and need cell
    
 
    if (currentPaint.need == [NSNumber numberWithChar:1]){
        needImageView.image = [UIImage imageNamed:@"Need"];
        [needUISwitch setOn:YES animated:NO];
        
    } else {
        needImageView.image = [UIImage imageNamed:@"Need-Not"];
        [needUISwitch setOn:NO animated:NO];
        
    }
    
    
    if (currentPaint.have == [NSNumber numberWithChar:1]){
        
        // if it is currently yes and we are toggling set the value to no
        haveImageView.image = [UIImage imageNamed:@"Have"];
        [haveUISwitch setOn:YES animated:NO];
        
    } else {
    
        haveImageView.image = [UIImage imageNamed:@"Have-Not"];
          [haveUISwitch setOn:NO animated:NO];
        
    }
    
        
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)toggleNeed:(id)sender {
    
    // update core data and change the image
    
  
    if (needUISwitch.on){
        
        // if it is currently yes and we are toggling set the value to no
        currentPaint.need = [NSNumber numberWithChar:1];
        needImageView.image = [UIImage imageNamed:@"Need"];

        
    } else {
        currentPaint.need = [NSNumber numberWithChar:0];
        needImageView.image = [UIImage imageNamed:@"Need-Not"];
        
    }
    
    
    
  [self.appdelegate saveContext];
  
  
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}
- (IBAction)toggleHave:(id)sender {
    // update core data and change the image

    
      if (haveUISwitch.on){
        
        // if it is currently yes and we are toggling set the value to no
          currentPaint.have = [NSNumber numberWithChar:1];
        haveImageView.image = [UIImage imageNamed:@"Have"];
        
        
    } else {
        currentPaint.have = [NSNumber numberWithChar:0];
        haveImageView.image = [UIImage imageNamed:@"Have-Not"];
        
    }
    [self.appdelegate saveContext];
    
    
  NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"prepareForSeque to DetailView");
    
    WCPigmentDetailTableViewController *dvc = (WCPigmentDetailTableViewController *)[segue destinationViewController];
    
    
    //  Pass the Pigment data object  to the destination view controller
    
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Pigment *thisPigment = self.pigments[indexPath.row];
    
    dvc.currentPigment = thisPigment;
}

#pragma mark - Table view data source

//  Return the number of sections in the table
//*******************************************************************************************************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}

//  Return the number of rows in the section (the amount of items in our array)
//*******************************************************************************************************************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count_row = 1;
    
    if (section== 0) {
        // if there are no reqs we want one row with no pending req
        
        count_row = [self.pigments count];
    }
    return count_row;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    UILabel *label = nil;
    UIImageView *thePaintImage=nil;

    
    switch (indexPath.section) {
            
        case 0:  // Pigment - PigmentCell
        {
            CellIdentifier = @"PigmentCell";
            break;
        }
        case 1:  // Information - InformationCell
        {
             CellIdentifier = @"InformationCell";
            break;
        }
        case 2:  // Other Names - OtherNamesCell
        {
             CellIdentifier = @"OtherNamesCell";
            break;
        }
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    switch (indexPath.section) {
                case 0:  // Pigment - PigmentCell
        {
            
            Pigment *thisPigment = self.pigments[indexPath.row];
            
            label = (UILabel *)[cell.contentView viewWithTag:3010];
            [label setText:[NSString stringWithFormat:@"%@", thisPigment.pigment_words]];
            
            label = (UILabel *)[cell.contentView viewWithTag:3020];
            [label setText:[NSString stringWithFormat:@"%@", thisPigment.pigment_code]];
            
            label = (UILabel *)[cell.contentView viewWithTag:3030];
            [label setText:[NSString stringWithFormat:@"%@", thisPigment.chemical_name]];
            
            thePaintImage = (UIImageView *)[cell.contentView viewWithTag:3050];
            thePaintImage.image = [UIImage imageNamed:thisPigment.image_name];
            
            break;
        }
        case 1:  // Information - InformationCell
        {
            
            label = (UILabel *)[cell.contentView viewWithTag:2000];
            [label setText:currentPaint.paint_history];
            break;
        }
        case 2:  // Other Names - OtherNamesCell
        {
            
            label = (UILabel *)[cell.contentView viewWithTag:4000];
            [label setText:currentPaint.other_names];
            break;
        }
            
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    
    NSString *thisSectionName = nil;
    
    
    switch (section) {
            
        case 0:  // Pigment - PigmentCell
        {
            thisSectionName = @"Pigments";
            break;
        }
        case 1:  // Information - InformationCell
        {
            thisSectionName = @"Information";
            break;
        }
        case 2:  // Other Names - OtherNamesCell
        {
            thisSectionName = @"Other Names";
            break;
        }
    }
    
    return thisSectionName;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 44.0f;
    
    switch (indexPath.section) {
            
        case 0:  // Pigment - PigmentCell
        {
           cellHeight = 80.0f;
            break;
        }
        case 1:  // Information - InformationCell
        {
            cellHeight = 80.0f;
            break;
        }
        case 2:  // Other Names - OtherNamesCell
        {
            cellHeight = 80.0f;
            break;
        }
    }
    return cellHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat cellHeight = 30.f;
    
    
  /*  if (section==0) {
        cellHeight = 0.f;
    }*/
    return cellHeight;
}

@end
