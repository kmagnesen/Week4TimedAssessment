//
//  DogOwner.m
//  Week4TimedAssessment
//
//  Created by Kyle Magnesen on 1/30/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "DogOwner.h"
#import "Person.h"

@implementation DogOwner

-(void)retrieveListOwnersWithCompletion:(void(^)(NSArray *))complete{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO]];

    NSError *error;
    self.listPerson = [self.moc executeFetchRequest:request error:&error];

    if (!error) {
        if (!self.listPerson || self.listPerson.count == 0) {
            [self retrieveDataJsonWithCompletion:^(NSArray *people) {
                NSArray *aux = people;
                self.listPerson = [Person personsFromArray:aux withManagedObjectContext:self.moc];
                NSError *error;
                [self.moc save:&error];
                if (error) {
                    NSLog(@"Error: %@, %@",error,error.userInfo);
                }

                complete(self.listPerson);
            }];
        }else{
            complete(self.listPerson);
        }
    }
}

-(void)retrieveDataJsonWithCompletion:(void (^)(NSArray *))complete{
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSArray *dogowners = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];

        complete(dogowners);
    }];
}

@end
