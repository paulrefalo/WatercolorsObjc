//
//  Paint+Extras.m
//  WatercolorCoreData
//
//  Created by Leisa Refalo on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "Paint+Extras.h"

@implementation Paint (Extras)


+ (Paint *)paintWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context
{
    Paint *thisPaint = nil;
    
    if ([name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Paint"];
        
        request.predicate = [NSPredicate predicateWithFormat:@"paint_name = %@", name];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            thisPaint = [NSEntityDescription insertNewObjectForEntityForName:@"Paint"
                                                        inManagedObjectContext:context];
            thisPaint.paint_name = name;
            
        } else {
            thisPaint = [matches lastObject];
        }
    }
    return thisPaint;
}
@end
