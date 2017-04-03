//
//  main.m
//  WatercolorCoreData
//
//  Created by Leisa Refalo on 4/17/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//
#import "Paint.h"
#import "Pigment.h"
#import "Pigment+Extras.h"

static NSManagedObjectModel *managedObjectModel()
{
    static NSManagedObjectModel *model = nil;
    if (model != nil) {
        return model;
    }
    
    NSString *path = @"PaintModel";
    path = [path stringByDeletingPathExtension];
    NSURL *modelURL = [NSURL fileURLWithPath:[path stringByAppendingPathExtension:@"momd"]];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return model;
}

static NSManagedObjectContext *managedObjectContext()
{
    static NSManagedObjectContext *context = nil;
    if (context != nil) {
        return context;
    }

    @autoreleasepool {
        context = [[NSManagedObjectContext alloc] init];
        
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel()];
        [context setPersistentStoreCoordinator:coordinator];
        
        NSString *STORE_TYPE = NSSQLiteStoreType;
        
        NSString *path = [[NSProcessInfo processInfo] arguments][0];
        path = [path stringByDeletingPathExtension];
        NSURL *url = [NSURL fileURLWithPath:[path stringByAppendingPathExtension:@"sqlite"]];
        
        NSError *error;
        NSPersistentStore *newStore = [coordinator addPersistentStoreWithType:STORE_TYPE configuration:nil URL:url options:nil error:&error];
        
        if (newStore == nil) {
            NSLog(@"Store Configuration Failure %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        }
    }
    return context;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        // Create the managed object context
        NSManagedObjectContext *context = managedObjectContext();
        
        // Custom code here...
        // Save the managed object context
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error while saving %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
            exit(1);
        }
        
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
            
            Pigment *thisPigment = [NSEntityDescription
                                     insertNewObjectForEntityForName:@"Pigment"
                                     inManagedObjectContext:context];
            NSString *thisCode  = [obj objectForKey:@"pigment_code"];
             NSString *thisName = [obj objectForKey:@"pigment_name"];
            
             NSLog(@"The name is: %@", thisCode);
             NSLog(@"The code is: %@", thisName);
            
            thisPigment.pigment_code = [obj objectForKey:@"pigment_code"];
            thisPigment.pigment_name =  [obj objectForKey:@"pigment_name"];
            thisPigment.image_name = [obj objectForKey:@"image_name"];
            thisPigment.pigment_words = [obj objectForKey:@"pigment_words"];
            thisPigment.pigment_type = [obj objectForKey:@"pigment_type"];
            thisPigment.chemical_name = [obj objectForKey:@"chemical_name"];
            thisPigment.chemical_formula = [obj objectForKey:@"chemical_formula"];
            thisPigment.properties = [obj objectForKey:@"properties"];
            
            thisPigment.permanence = [obj objectForKey:@"permanence"];
            thisPigment.properties = [obj objectForKey:@"properties"];
            thisPigment.toxicity = [obj objectForKey:@"toxicity"];
            thisPigment.history = [obj objectForKey:@"history"];
            thisPigment.alternative_names = [obj objectForKey:@"alternative_names"];


            
            
            NSError *error1;
            if (![context save:&error1]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
        }];
        
        // Test listing all FailedBankInfos from the store
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pigment"
                                                  inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
      /*  for (Pigment *info in fetchedObjects) {
            NSLog(@"Name: %@, Phrase: %@", info.pigment_name, info.image_name);
        }*/
        


    /****************************************************************/
    // Load Paints
        // Retrieve local JSON file called paint.json
        
        NSString *paintFilePath = [[NSBundle mainBundle] pathForResource:@"paints" ofType:@"json"];
        NSLog(@"The file path is: %@", paintFilePath);
        
        // Load the file into an NSData object called JSONData
        
        NSArray* paintJSONData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:paintFilePath]
                                                                   options:kNilOptions
                                                                     error:&err];
        
        NSLog(@"Imported myJSON: %@", paintJSONData);
        
        [paintJSONData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            Paint *thisPaint = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"Paint"
                                    inManagedObjectContext:context];
            
            thisPaint.paint_name = [obj objectForKey:@"paint_name"];
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
                
                Pigment *onePigment = [Pigment pigmentWithName:object inManagedObjectContext:context];
                
                [thisPaint addContainsObject:onePigment];
                 NSLog(@"The pigment name is: %@", onePigment.pigment_name);
                
            }
           //  thisPaint.pigments = [obj objectForKey:@"pigments"];
             thisPaint.lightfast_rating = [obj objectForKey:@"lightfast_rating"];
             thisPaint.opacity = [obj objectForKey:@"opacity"];
             thisPaint.staining_granulating = [obj objectForKey:@"staining_granulating"];
            
            NSError *error1;
            if (![context save:&error1]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
        }];
        
        // Test listing all FailedBankInfos from the store
        fetchRequest = [[NSFetchRequest alloc] init];
        entity = [NSEntityDescription entityForName:@"Paint"
                                                  inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
     /*   for (Paint *info in fetchedObjects) {
            NSLog(@"Name: %@, Phrase: %@", info.paint_name, info.sort_order);
        }*/
        
        
    }
    return 0;
}

