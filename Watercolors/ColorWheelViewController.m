//
//  WCFirstViewController.m
//  Watercolors
//
//  Created by Leisa Refalo on 4/15/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "ColorWheelViewController.h"
#import "FamilyTableViewController.h"

@interface ColorWheelViewController ()

@end

@implementation ColorWheelViewController
@synthesize colorTouched;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
      //  NSLog(@"Button pressed: %d", [sender tag]);
    
    switch ([sender tag]) {
        case 10:
            colorTouched = @"Yellows";
            break;
        case 20:
            colorTouched = @"Oranges";
            break;
        case 30:
            colorTouched = @"Reds";
            break;
        case 40:
            colorTouched = @"Violets";
            break;
        case 50:
            colorTouched = @"Blues";
            break;
        case 60:
            colorTouched = @"Greens";
            break;
        case 70:
            colorTouched = @"Earth Tones";
            break;
        case 80:
            colorTouched = @"Whites";
            break;
        case 90:
            colorTouched = @"Blacks";
            break;
        default:
            break;
    }
    NSLog(@"title will be: %@", colorTouched);
    
    [self performSegueWithIdentifier:@"showFamilySegue" sender:nil];
    
    
    
}

//  When a table row is selected
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  
    
    // check for which segue
    if ([[segue identifier] isEqualToString:@"showFamilySegue"]) {
    
        //  Get a reference to our detail view
        FamilyTableViewController *tvc = (FamilyTableViewController *)[segue destinationViewController];
        tvc.title_str = colorTouched;
    }
}
@end
