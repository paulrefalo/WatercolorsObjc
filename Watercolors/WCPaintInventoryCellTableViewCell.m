//
//  WCPaintInventoryCellTableViewCell.m
//  Watercolors
//
//  Created by Leisa on 6/19/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "WCPaintInventoryCellTableViewCell.h"

@implementation WCPaintInventoryCellTableViewCell


@synthesize haveImageView;
@synthesize wantImageView;
@synthesize haveUISwitch;
@synthesize wantUISwitch;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        

    }
    

    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)toggleWant:(id)sender {
    
    // update core data and change the image
    
    
    if (wantUISwitch.on){
        
        // if it is currently yes and we are toggling set the value to no
        wantImageView.image = [UIImage imageNamed:@"Want"];
    } else {
        wantImageView.image = [UIImage imageNamed:@"Want-Not"];
        
    }
}
- (IBAction)toggleHave:(id)sender {
    // update core data and change the image
    
    
    if (haveUISwitch.on){
        
        // if it is currently yes and we are toggling set the value to no
        haveImageView.image = [UIImage imageNamed:@"Have"];
    } else {
        haveImageView.image = [UIImage imageNamed:@"Have-Not"];
        
    }
}
// Tell our delegate the switch changed
 -(void)valueChange:(id)sender
{
    [delegate valueChangeNotify:sender];
}


@end
