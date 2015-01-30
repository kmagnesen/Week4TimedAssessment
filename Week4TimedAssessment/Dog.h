//
//  Dog.h
//  Week4TimedAssessment
//
//  Created by Kyle Magnesen on 1/29/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Dog : NSManagedObject

@property (nonatomic, retain) NSString * breed;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) Person *persons;

@end
