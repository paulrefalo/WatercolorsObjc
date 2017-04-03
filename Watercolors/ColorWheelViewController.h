//
//  WCFirstViewController.h
//  Watercolors
//
//  Created by Leisa Refalo on 4/15/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorWheelViewController : UIViewController
@property (strong, nonatomic) NSString * colorTouched;
- (IBAction)buttonPressed:(id)sender;

@end
