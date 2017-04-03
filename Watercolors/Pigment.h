//
//  Pigment.h
//  Watercolors
//
//  Created by Leisa Refalo on 6/23/14.
//  Copyright (c) 2014 Refalo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Paint;

@interface Pigment : NSManagedObject

@property (nonatomic, retain) NSString * alternative_names;
@property (nonatomic, retain) NSString * chemical_formula;
@property (nonatomic, retain) NSString * chemical_name;
@property (nonatomic, retain) NSString * history;
@property (nonatomic, retain) NSString * image_name;
@property (nonatomic, retain) NSString * permanence;
@property (nonatomic, retain) NSString * pigment_code;
@property (nonatomic, retain) NSString * pigment_name;
@property (nonatomic, retain) NSString * pigment_type;
@property (nonatomic, retain) NSString * pigment_words;
@property (nonatomic, retain) NSString * properties;
@property (nonatomic, retain) NSString * toxicity;
@property (nonatomic, retain) NSSet *used_in;
@end

@interface Pigment (CoreDataGeneratedAccessors)

- (void)addUsed_inObject:(Paint *)value;
- (void)removeUsed_inObject:(Paint *)value;
- (void)addUsed_in:(NSSet *)values;
- (void)removeUsed_in:(NSSet *)values;

@end
