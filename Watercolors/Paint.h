//
//  Paint.h
//  Watercolors
//
//  Created by Leisa Refalo on 6/23/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pigment;

@interface Paint : NSManagedObject

@property (nonatomic, retain) NSString * color_family;
@property (nonatomic, retain) NSNumber * have;
@property (nonatomic, retain) NSString * lightfast_rating;
@property (nonatomic, retain) NSString * opacity;
@property (nonatomic, retain) NSString * other_names;
@property (nonatomic, retain) NSString * paint_name;
@property (nonatomic, retain) NSNumber * paint_number;
@property (nonatomic, retain) NSString * pigment_composition;
@property (nonatomic, retain) NSString * pigments;
@property (nonatomic, retain) NSNumber * sort_order;
@property (nonatomic, retain) NSString * staining_granulating;
@property (nonatomic, retain) NSString * temperature;
@property (nonatomic, retain) NSNumber * need;
@property (nonatomic, retain) NSString * paint_history;
@property (nonatomic, retain) NSSet *contains;
@end

@interface Paint (CoreDataGeneratedAccessors)

- (void)addContainsObject:(Pigment *)value;
- (void)removeContainsObject:(Pigment *)value;
- (void)addContains:(NSSet *)values;
- (void)removeContains:(NSSet *)values;

@end
