//
//  Pigment+Extras.h
//  WatercolorCoreData
//
//  Created by Leisa Refalo on 4/28/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import "Pigment.h"

@interface Pigment (Extras)

+ (Pigment *)pigmentWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;


@end
