//
//  WCPigmentDetailViewController.h
//  Watercolors
//
//  Created by Leisa on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pigment.h"

@interface WCPigmentDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

@property (weak, nonatomic) IBOutlet UIImageView *pigmentImageView;

@property (strong, nonatomic) NSString *titleStr;
@property (strong, nonatomic) NSString *contentStr;
@property (weak, nonatomic) IBOutlet UILabel *pigmentNameLabel;

@property (strong, nonatomic) Pigment *currentPigment;

@end
