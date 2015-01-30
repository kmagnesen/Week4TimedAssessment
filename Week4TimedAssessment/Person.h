//
//  Person.h
//  Week4TimedAssessment
//
//  Created by Kyle Magnesen on 1/29/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *dogs;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addDogsObject:(NSManagedObject *)value;
- (void)removeDogsObject:(NSManagedObject *)value;
- (void)addDogs:(NSSet *)values;
- (void)removeDogs:(NSSet *)values;

@end
