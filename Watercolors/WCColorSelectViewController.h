//
//  WCColorSelectViewController.h
//  Watercolors
//
//  Created by Leisa on 6/19/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCColorSelectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *ColorFlowerImageView;
@property (strong, nonatomic) NSString * colorTouched;
@property (strong, nonatomic) NSString * colorCode;
@end
