//
//  WCPaintInventoryCellTableViewCell.h
//  Watercolors
//
//  Created by Leisa on 6/19/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SwitchDelegate <NSObject>

- (void)valueChangeNotify:(id)sender;

@end

@interface WCPaintInventoryCellTableViewCell : UITableViewCell {

    id<SwitchDelegate> delegate;
}
//@property (nonatomic, assign) id <SwitchDelegate> delegate;


@property (weak, nonatomic) IBOutlet UIImageView *haveImageView;
@property (weak, nonatomic) IBOutlet UIImageView *wantImageView;


@property (weak, nonatomic) IBOutlet UISwitch *wantUISwitch;
@property (weak, nonatomic) IBOutlet UISwitch *haveUISwitch;

- (IBAction)toggleWant:(id)sender;
- (IBAction)toggleHave:(id)sender;

-(void)valueChange:(id)sender;

@end
