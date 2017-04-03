//
//  WCColorSelectViewController.m
//  Watercolors
//
//  Created by Leisa on 6/19/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "WCColorSelectViewController.h"
#import "FamilyTableViewController.h"

@interface WCColorSelectViewController ()

@end

@implementation WCColorSelectViewController
@synthesize colorTouched;
@synthesize colorCode;

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
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.ColorFlowerImageView addGestureRecognizer:tapRecognizer];
    self.ColorFlowerImageView.userInteractionEnabled = YES;
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tapGesture:(UITapGestureRecognizer *)recognizer
{

    colorTouched = nil;

    CGPoint point = [recognizer locationInView:self.ColorFlowerImageView];
    
    UIGraphicsBeginImageContext(self.ColorFlowerImageView.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.ColorFlowerImageView.layer renderInContext:context];
    
    int bpr = CGBitmapContextGetBytesPerRow(context);
    unsigned char * data = CGBitmapContextGetData(context);
    if (data != NULL)
    {
        int offset = bpr*round(point.y) + 4*round(point.x);
        int blue = data[offset+0];
        int green = data[offset+1];
        int red = data[offset+2];
        int alpha =  data[offset+3];
        
        
        colorCode = [NSString stringWithFormat:@"%d %d %d %d", alpha, red, green, blue];

        NSLog(@"%d %d %d %d", alpha, red, green, blue);
        
        // White 0 0 0 0 - Background was tapped
        
        // Red 255 237 28 36
        // Orange 255 241 89 42
        
        // Yellow 255 245 238 49
        // Green 255 11 148 68
        // Blue 255 15 117 188

        
        // Yellow 255 255 242 0
        // Green 255 11 148 68
        // Blue 255 46 49 146

        
        // Violet 255 102 45 145
        // Brown 255 90 74 66
        // Gray 255 147 149 152
     
        if ([colorCode isEqualToString:@"255 245 238 49"]) {}

       if ([colorCode isEqualToString:@"255 255 242 0"]) {
            colorTouched = @"Yellows";
        }
       
        if ([colorCode isEqualToString:@"255 241 89 42"]) {
            colorTouched = @"Oranges";
        }
        
        if ([colorCode isEqualToString:@"255 237 28 36"]) {
            colorTouched = @"Reds";
        }
        
        if ([colorCode isEqualToString:@"255 102 45 145"]) {
            colorTouched = @"Violets";
        
        }
        
        if ([colorCode isEqualToString:@"255 15 117 188"]) {
        }
    
        if ([colorCode isEqualToString:@"255 46 49 146"]) {
            colorTouched = @"Blues";
        }
        
        if ([colorCode isEqualToString:@"255 11 148 68"]){
            colorTouched = @"Greens";
        }
        
        if ([colorCode isEqualToString:@"255 90 74 66"])
        {
            colorTouched = @"Earth Tones";
        }

        if ([colorCode isEqualToString:@"255 147 149 152"])
        {
            colorTouched = @"Monochrome";
        }
        
        if ([colorCode isEqualToString:@"255 5 7 7"])
        {
            colorTouched = @"Blacks";
        }
        
        if ([colorCode isEqualToString:@"255 255 255 255"])
        {
            colorTouched = @"Whites";
        }
        
//        if ([colorCode isEqualToString:@"255 234 157 166"])
//        {
//            //light red
//            colorTouched = @"Reds";
//        }
        
        if ([colorCode isEqualToString:@"255 98 102 147"])
        {
            //light blue
            colorTouched = @"Blues";
        }
        
        if ([colorCode isEqualToString:@"255 250 244 132"])
        {
            //light yellow
            colorTouched = @"Yellows";
        }
        
        
        if (colorTouched)
        {
            [self performSegueWithIdentifier:@"showColorFamilySegue" sender:nil];
            NSLog(@"Color was tapped: %@", colorTouched);

        }

        

    }
    
    UIGraphicsEndImageContext();
}





//  When a table row is selected
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    // check for which segue
    if ([[segue identifier] isEqualToString:@"showColorFamilySegue"]) {
        
        //  Get a reference to our detail view
        FamilyTableViewController *tvc = (FamilyTableViewController *)[segue destinationViewController];
        tvc.title_str = colorTouched;
    }
}
@end
