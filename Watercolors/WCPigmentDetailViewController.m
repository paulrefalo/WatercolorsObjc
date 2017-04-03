//
//  WCPigmentDetailViewController.m
//  Watercolors
//
//  Created by Leisa on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "WCPigmentDetailViewController.h"

@interface WCPigmentDetailViewController ()

@end

@implementation WCPigmentDetailViewController
@synthesize pigmentImageView;
@synthesize currentPigment;
@synthesize pigmentNameLabel;

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

    self.detailTextView.text = self.contentStr;
    self.title =  self.titleStr;
    
    pigmentImageView.image = [UIImage imageNamed:currentPigment.image_name];

    pigmentNameLabel.text = currentPigment.pigment_name;

    
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
