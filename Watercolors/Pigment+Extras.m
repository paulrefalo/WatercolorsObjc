//
//  Pigment+Extras.m
//  WatercolorCoreData
//
//  Created by Leisa Refalo on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "Pigment+Extras.h"

@implementation Pigment (Extras)


+ (Pigment *)pigmentWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context
{
    Pigment *thisPigment = nil;
    
    if ([name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pigment"];
        
        request.predicate = [NSPredicate predicateWithFormat:@"pigment_name = %@", name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            thisPigment = [NSEntityDescription insertNewObjectForEntityForName:@"Pigment"
                                                    inManagedObjectContext:context];
            thisPigment.pigment_name = name;

        } else {
            thisPigment = [matches lastObject];
        }
    }
    
    return thisPigment;
}
@end
