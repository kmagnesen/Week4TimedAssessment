//
//  Person.m
//  Week4TimedAssessment
//
//  Created by Kyle Magnesen on 1/30/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "Person.h"


@implementation Person

@dynamic name;
@dynamic dogs;

+ (NSArray *)personsFromArray:(NSArray *)tempPersons withManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    
    NSMutableArray *persons = [NSMutableArray new];

    for (NSString *name in tempPersons)
    {
        Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:managedObjectContext];
        person.name = name;

        [persons addObject:person];
    }

    return persons;
}

@end
