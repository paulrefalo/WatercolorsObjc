//
//  WCDetailTableViewController.h
//  Watercolors
//
//  Created by Leisa on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Paint.h"
#import "Pigment.h"
#import "WCAppDelegate.h"
#import "WCAppDelegate+MOC.h"

@interface WCPaintDetailTableViewController : UITableViewController
@property (strong, nonatomic) Paint *currentPaint;
@property (weak, nonatomic) IBOutlet UILabel *lightFastLabel;
@property (weak, nonatomic) IBOutlet UILabel *opacityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stainingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *paintImageView;



@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *haveUISwitch;

- (IBAction)toggleHave:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *needUISwitch;

- (IBAction)toggleNeed:(id)sender;


@property (weak, nonatomic) IBOutlet UIImageView *haveImageView;
@property (weak, nonatomic) IBOutlet UIImageView *needImageView;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) WCAppDelegate *appdelegate;


@property (nonatomic, strong) NSArray *pigments;


@end
