//
//  WCPigmentDetailTableViewController.m
//  Watercolors
//
//  Created by Leisa on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "WCPigmentDetailTableViewController.h"
#import "WCPigmentDetailViewController.h"

@interface WCPigmentDetailTableViewController ()

@end

@implementation WCPigmentDetailTableViewController
@synthesize currentPigment;
@synthesize PigmentImageView;
@synthesize PigmentImageView2;
@synthesize PigmentImageView3;
@synthesize PigmentImageView4;
@synthesize PigmentImageView5;
@synthesize PigmentImageView6;
@synthesize PigmentImageView7;
@synthesize PigmentNameLabel;
@synthesize PigmentTypeLabel;
@synthesize ChemicalNameLabel;
@synthesize ChemicalStructureLabel;
@synthesize PropertiesLabel;
@synthesize PermanenceLabel;
@synthesize ToxicityLabel;
@synthesize HistoryLabel;
@synthesize AltNamesLabel;

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
    
 
    PigmentImageView.image = [UIImage imageNamed:currentPigment.image_name];
    PigmentImageView2.image = [UIImage imageNamed:currentPigment.image_name];
     PigmentImageView2.image = [UIImage imageNamed:currentPigment.image_name];
     PigmentImageView3.image = [UIImage imageNamed:currentPigment.image_name];
     PigmentImageView4.image = [UIImage imageNamed:currentPigment.image_name];
     PigmentImageView5.image = [UIImage imageNamed:currentPigment.image_name];
     PigmentImageView6.image = [UIImage imageNamed:currentPigment.image_name];
     PigmentImageView7.image = [UIImage imageNamed:currentPigment.image_name];
    PigmentNameLabel.text = currentPigment.pigment_name;
    ChemicalNameLabel.text = currentPigment.chemical_name;
    ChemicalStructureLabel.text = currentPigment.chemical_formula;
    PropertiesLabel.text = currentPigment.properties;
    PermanenceLabel.text = currentPigment.permanence;
    ToxicityLabel.text = currentPigment.toxicity;
    HistoryLabel.text = currentPigment.history;
    AltNamesLabel.text = currentPigment.alternative_names;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  
    // Pass the selected object to the new view controller.
    
    NSLog(@"prepareForSeque to DetailView");
    
      NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    //NSLog(@"indexPath is %d",  indexPath.row);
          
    WCPigmentDetailViewController *dvc = (WCPigmentDetailViewController *)[segue destinationViewController];
    
        if (indexPath.row == 0) {
            dvc.titleStr = @"Properties";
            dvc.contentStr = currentPigment.properties;
        } else if (indexPath.row == 1){
  
            dvc.titleStr = @"Permanence";
            dvc.contentStr = currentPigment.permanence;
    } else if (indexPath.row == 2){
            dvc.titleStr = @"Toxicity";
            dvc.contentStr = currentPigment.toxicity;
} else if (indexPath.row == 3) {
            dvc.titleStr = @"History";
            dvc.contentStr = currentPigment.history;
} else if (indexPath.row == 4){
            dvc.titleStr = @"Alternative Names";
    dvc.contentStr = currentPigment.alternative_names;


        } else {

            dvc.titleStr = @"n/a";
            dvc.contentStr = @"n/a";         }
    
        dvc.pigmentImageView.image  = [UIImage imageNamed:currentPigment.image_name];
        dvc.pigmentNameLabel.text = currentPigment.pigment_name;
        dvc.currentPigment = currentPigment;

    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
            [self performSegueWithIdentifier:@"PigmentDetailSegue" sender:nil];
            
            break;
        default:
            break;
    }
}


-(BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return NO;
}
@end
