//
//  WCPigmentDetailTableViewController.h
//  Watercolors
//
//  Created by Leisa on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pigment.h"
@interface WCPigmentDetailTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *PigmentImageView7;
@property (weak, nonatomic) IBOutlet UIImageView *PigmentImageView6;
@property (weak, nonatomic) IBOutlet UIImageView *PigmentImageView5;
@property (strong, nonatomic) Pigment *currentPigment;
@property (weak, nonatomic) IBOutlet UIImageView *PigmentImageView4;

@property (weak, nonatomic) IBOutlet UIImageView *PigmentImageView3;

@property (weak, nonatomic) IBOutlet UIImageView *PigmentImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *PigmentImageView;

@property (weak, nonatomic) IBOutlet UILabel *PigmentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PigmentTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ChemicalNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ChemicalStructureLabel;
@property (weak, nonatomic) IBOutlet UILabel *PropertiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *PermanenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ToxicityLabel;
@property (weak, nonatomic) IBOutlet UILabel *HistoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *AltNamesLabel;

@end
