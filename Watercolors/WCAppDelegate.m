//
//  WCAppDelegate.m
//  Watercolors
//
//  Created by Leisa Refalo on 4/15/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//
#import <CoreData/CoreData.h>
#import "WCAppDelegate.h"
#import "WCAppDelegate+MOC.h"
#import "Paint.h"
#import "Paint+Extras.h"
#import "Pigment.h"
#import "Pigment+Extras.h"
@implementation WCAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //CoreData -  get the managed object context
    self.managedObjectContext = [self getManagedObjectContext];
    
    //load data if first run
    [self loadPigment];
    [self loadPaint];

    return YES;
}


-(void)loadPigment {
    
    NSError* err = nil;
    
    /****************************************************************/
    // Load Pigments
    // Retrieve local JSON file called pigment.json
    
    NSString *pigmentFilePath = [[NSBundle mainBundle] pathForResource:@"pigment" ofType:@"json"];
    NSLog(@"The file path is: %@", pigmentFilePath);
    
    // Load the file into an NSData object called JSONData
    
    NSArray* pigmentJSONData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:pigmentFilePath]
                                                               options:kNilOptions
                                                                 error:&err];
    
    //  NSLog(@"Imported myJSON: %@", pigmentJSONData)
    
    [pigmentJSONData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        Pigment *thisPigment = [Pigment pigmentWithName:[obj objectForKey:@"pigment_name"] inManagedObjectContext:self.managedObjectContext];
        
        
        thisPigment.pigment_code = [obj objectForKey:@"pigment_code"];
        thisPigment.pigment_name =  [obj objectForKey:@"pigment_name"];
        thisPigment.image_name = [obj objectForKey:@"image_name"];
        thisPigment.pigment_words = [obj objectForKey:@"pigment_words"];
        thisPigment.pigment_type = [obj objectForKey:@"pigment_type"];
        thisPigment.chemical_name = [obj objectForKey:@"chemical_name"];
        thisPigment.chemical_formula = [obj objectForKey:@"chemical_formula"];
        thisPigment.properties = [obj objectForKey:@"properties"];
        thisPigment.permanence = [obj objectForKey:@"permanence"];
        thisPigment.toxicity = [obj objectForKey:@"toxicity"];
        thisPigment.history = [obj objectForKey:@"history"];
        thisPigment.alternative_names = [obj objectForKey:@"alternative_names"];
        
        
        
        
        NSError *error1;
        if (![self.managedObjectContext save:&error1]) {
            NSLog(@"Whoops, couldn't save: %@", [error1 localizedDescription]);
        }
    }];
    
    // Test listing all FailedBankInfos from the store
   NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pigment"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&err];
      for (Pigment *info in fetchedObjects) {
     NSLog(@"Name: %@, Phrase: %@", info.pigment_name, info.image_name);
     }
}
-(void)loadPaint {
    
 
    
    
    
    /****************************************************************/
    // Load Paints
    // Retrieve local JSON file called paint.json
    NSError *err;
    NSString *paintFilePath = [[NSBundle mainBundle] pathForResource:@"paint" ofType:@"json"];
    NSLog(@"The file path is: %@", paintFilePath);
    
    // Load the file into an NSData object called JSONData
    
    NSArray* paintJSONData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:paintFilePath]
                                                             options:kNilOptions
                                                               error:&err];
    
   // NSLog(@"Imported myJSON: %@", paintJSONData);
    
    [paintJSONData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        Paint *thisPaint = [Paint paintWithName: [obj objectForKey:@"paint_name"] inManagedObjectContext:self.managedObjectContext];
        
        
        
      //  thisPaint.paint_name = [obj objectForKey:@"paint_name"];
        thisPaint.paint_number = [obj objectForKey:@"paint_number"];
        thisPaint.temperature = [obj objectForKey:@"temperature"];
        thisPaint.sort_order = [obj objectForKey:@"sort_order"];
        thisPaint.color_family = [obj objectForKey:@"color_family"];
        thisPaint.pigment_composition = [obj objectForKey:@"pigment_composition"];
        
        // Look Up Pigments
        NSString *pigmentString = [obj objectForKey:@"pigments"];
        thisPaint.pigments = pigmentString;
        NSArray *pigmentArray = [pigmentString componentsSeparatedByString:@","];
        
        for (id object in pigmentArray) {
            // do something with object
            
            Pigment *onePigment = [Pigment pigmentWithName:object inManagedObjectContext:self.managedObjectContext];
            
            [thisPaint addContainsObject:onePigment];
           // NSLog(@"The pigment name is: %@", onePigment.pigment_name);
            
        }
       thisPaint.paint_history = [obj objectForKey:@"history"];
        thisPaint.lightfast_rating = [obj objectForKey:@"lightfast_rating"];
        thisPaint.opacity = [obj objectForKey:@"opacity"];
        thisPaint.staining_granulating = [obj objectForKey:@"staining_granulating"];
        thisPaint.other_names = [obj objectForKey:@"other_names"];
        
        
        NSError *error1;
        if (![self.managedObjectContext save:&error1]) {
            NSLog(@"Whoops, couldn't save: %@", [err localizedDescription]);
        }

    }];




}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     [self saveContext];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     [self saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     [self saveContext];
}

@end
