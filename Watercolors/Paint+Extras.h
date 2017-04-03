//
//  Paint+Extras.h
//  WatercolorCoreData
//
//  Created by Leisa Refalo on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "Paint.h"

@interface Paint (Extras)
+ (Paint *)paintWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

@end
