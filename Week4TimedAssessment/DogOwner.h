//
//  DogOwner.h
//  Week4TimedAssessment
//
//  Created by Kyle Magnesen on 1/30/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface DogOwner : NSObject

@property NSArray *listPerson;
@property NSManagedObjectContext *moc;

-(void)retrieveListOwnersWithCompletion:(void(^)(NSArray *))complete;

@end
