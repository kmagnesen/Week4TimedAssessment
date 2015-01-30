//
//  DogsViewController.m
//  Week4TimedAssessment
//
//  Created by Kyle Magnesen on 1/29/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "AddDogViewController.h"
#import "Dog.h"

@interface DogsViewController () <UITableViewDataSource, UITabBarDelegate>

@property NSMutableArray *dogs;

@property (strong, nonatomic) IBOutlet UITableView *dogsTableView;
@end

@implementation DogsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Dogs";

    self.dogs = [NSMutableArray arrayWithArray:[self.personOwner.dogs allObjects]];
    [self.dogsTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    self.dogs = [NSMutableArray arrayWithArray:[self.personOwner.dogs allObjects]];
    [self.dogsTableView reloadData];
}

#pragma mark ------------- TABLEVIEW DELEGATE AND DATASOURCE -------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dogs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Dog *dog = [self.dogs objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];
    //TODO: UPDATE THIS ACCORDINGLY
    cell.textLabel.text = dog.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Breed: %@   Color: %@", dog.breed, dog.color];

    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Dog *dogDeleted = [self.dogs objectAtIndex:indexPath.row];
        [self.personOwner removeDogsObject:dogDeleted];
        [self.personOwner.managedObjectContext save:nil];
        [self.dogs removeObjectAtIndex:indexPath.row];
        [self.dogsTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark ------------- PREPARE FOR SEGUE -----------------

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"addDogSegue"])
    {
        AddDogViewController *addDog = segue.destinationViewController;
        addDog.ownerSelected = self.personOwner;
    }
    else if([segue.identifier isEqualToString:@"updateDogSegue"])
    {
        UITableViewCell *cell = sender;
        AddDogViewController *addDog =segue.destinationViewController;
        addDog.dogSelect = [self.dogs objectAtIndex:[self.dogsTableView indexPathForCell:cell].row];
    }
}

@end
