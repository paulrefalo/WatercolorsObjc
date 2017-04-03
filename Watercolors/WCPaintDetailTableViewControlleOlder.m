//
//  WCDetailTableViewController.m
//  Watercolors
//
//  Created by Leisa on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "WCPaintDetailTableViewController.h"
#import "WCAppDelegate.h"
#import "WCAppDelegate+MOC.h"

@interface WCPaintDetailTableViewController ()

@end

@implementation WCPaintDetailTableViewController

@synthesize currentPaint;
@synthesize wantUISwitch;
@synthesize haveUISwitch;



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
    
    self.pigments = [self.currentPaint.contains allObjects];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	switch (section) {
		case 0:
			return 1;
        case 1:
			return 1;
        case 2:
			return 1;
        case 3:
			return 1;
		case 4:
			return [self.pigments count];
		default:
			return 0;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    switch (section) {
		case 0:
			return nil;
        case 1:
			return @"Pigment Composition";
        case 2:
			return @"My Inventory";
        case 3:
			return @"Other Names";
		case 4:
			return @"Pigments";
		default:
			return nil;
	}
	
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier;
	
	switch (indexPath.section) {
            // first section
        case 0:
            CellIdentifier = @"DetailCell";
            break;
        case 1:
            CellIdentifier = @"PigmentCompositionCell";
            break;
        case 2:
            CellIdentifier = @"InventoryCell";
            break;
        case 3:
			CellIdentifier = @"OtherNamesCell";
            break;
        case 4:
            CellIdentifier = @"PigmentCell";
		default:
			break;
	}
	
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *label;
	switch (indexPath.section) {

        case 0: {
            
            NSNumber *paintNumb = currentPaint.paint_number;
            NSString *paintImageName = [paintNumb stringValue];

            
            UIImageView *paintImageView = (UIImageView *)[cell.contentView viewWithTag:1000];
            paintImageView.image = [UIImage imageNamed:paintImageName];
           
            label = (UILabel *)[cell.contentView viewWithTag:1010];
            [label setText:[NSString stringWithFormat:@"$%@", currentPaint.paint_name]];
            
            label = (UILabel *)[cell.contentView viewWithTag:1020];
            [label setText:[NSString stringWithFormat:@"$%@", currentPaint.lightfast_rating]];
            
            label = (UILabel *)[cell.contentView viewWithTag:1030];
            [label setText:[NSString stringWithFormat:@"$%@", currentPaint.opacity]];
            
            label = (UILabel *)[cell.contentView viewWithTag:1040];
            [label setText:[NSString stringWithFormat:@"$%@", currentPaint.staining_granulating]];
            break;
            
        }
        case 1: {
            
            
            label = (UILabel *)[cell.contentView viewWithTag:2000];
            [label setText:[NSString stringWithFormat:@"$%@", currentPaint.pigment_composition]];
            break;
            
        } case 2: {
            
            
            
            
          
            
            // set up have and want cell
            UIImageView *wantImageView = (UIImageView *)[cell.contentView viewWithTag:3000];
            UISwitch *wantSwitch = (UISwitch *)[cell.contentView viewWithTag:3010];
            
            if (currentPaint.want.boolValue == YES){
                
                wantImageView.image = [UIImage imageNamed:@"Want"];
                [wantSwitch setOn:YES animated:NO];
                
            } else {
                wantImageView.image = [UIImage imageNamed:@"Want-Not"];
                [wantSwitch setOn:NO animated:NO];
                
            }
            
            UIImageView *haveImageView = (UIImageView *)[cell.contentView viewWithTag:3020];
            UISwitch *haveSwitch = (UISwitch *)[cell.contentView viewWithTag:3030];
            
            if (currentPaint.have.boolValue == YES){
                
                // if it is currently yes and we are toggling set the value to no
                haveImageView.image = [UIImage imageNamed:@"Have"];
                [haveSwitch setOn:YES animated:NO];
                
            } else {
                
                haveImageView.image = [UIImage imageNamed:@"Have-Not"];
                [haveSwitch setOn:NO animated:NO];
                
            }
            break;
        } case 3: {
            label = (UILabel *)[cell.contentView viewWithTag:4000];
            [label setText:[NSString stringWithFormat:@"$%@", currentPaint.other_names]];
            
            break;
        }case 4: {
            // Configure the cell...
             Pigment *this_pigment = [self.pigments  objectAtIndex:(indexPath.row)];
            // 10 Image
            
            UIImageView *pigmentImageView = (UIImageView *)[cell.contentView viewWithTag:10];
            pigmentImageView.image = [UIImage imageNamed:this_pigment.image_name];
            
            NSLog(@"image_name: %@", this_pigment.image_name);
            
            // 20 Title
            label = (UILabel *)[cell.contentView viewWithTag:20];
            [label setText:[NSString stringWithFormat:@"%@", this_pigment.pigment_code]];
            
            // 30 LightFast
            label = (UILabel *)[cell.contentView viewWithTag:30];
            [label setText:[NSString stringWithFormat:@"%@", this_pigment.pigment_words]];
            
            // 40 Opacity - staining_granulating - Temperature
            label = (UILabel *)[cell.contentView viewWithTag:40];
            [label setText:[NSString stringWithFormat:@"%@", this_pigment.chemical_name]];
            

        }
            
        default:
			break;
	}
    return cell;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)toggleWant:(id)sender {
    
    // update core data and change the image
    
  
    if (wantUISwitch.on){
        
        // if it is currently yes and we are toggling set the value to no
        currentPaint.want = [NSNumber numberWithBool:YES];
        
        self.wantImageView.image = [UIImage imageNamed:@"Want"];

        
    } else {
        currentPaint.want = [NSNumber numberWithBool:NO];
        self.wantImageView.image = [UIImage imageNamed:@"Want-Not"];
        
    }
    
    
    
 /* [self.appdelegate saveContext];
  
  
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }*/
}
- (IBAction)toggleHave:(id)sender {
    // update core data and change the image

    
      if (haveUISwitch.on){
        
        // if it is currently yes and we are toggling set the value to no
        currentPaint.have = [NSNumber numberWithBool:YES];
        self.haveImageView.image = [UIImage imageNamed:@"Have"];
        
        
    } else {
        currentPaint.have = [NSNumber numberWithBool:NO];
        self.haveImageView.image = [UIImage imageNamed:@"Have-Not"];
        
    }
    /*  [self.appdelegate saveContext];
    
    
  NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }*/
    
}
@end
