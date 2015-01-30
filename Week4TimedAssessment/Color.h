//
//  Color.h
//  Week4TimedAssessment
//
//  Created by Kyle Magnesen on 1/29/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Color : NSManagedObject

@property (nonatomic, retain) NSNumber * colorA;
@property (nonatomic, retain) NSNumber * colorR;
@property (nonatomic, retain) NSNumber * colorG;
@property (nonatomic, retain) NSNumber * colorB;

@end
