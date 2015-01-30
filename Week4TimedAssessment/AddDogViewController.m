//
//  AddDogViewController.m
//  Week4TimedAssessment
//
//  Created by Kyle Magnesen on 1/30/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"

@interface AddDogViewController ()

@property (strong, nonatomic) IBOutlet UITextField *colorTextField;
@property (strong, nonatomic) IBOutlet UITextField *breedTextField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation AddDogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Add Dog";
    
    if (self.dogSelect) {
        self.nameTextField.text = self.dogSelect.name;
        self.breedTextField.text = self.dogSelect.breed;
        self.colorTextField.text = self.dogSelect.color;

    }
}

- (IBAction)onFinishButtonTapped:(UIButton *)sender {
    if (self.dogSelect) { //update core data process

        self.dogSelect.name = self.nameTextField.text;
        self.dogSelect.breed = self.breedTextField.text;
        self.dogSelect.color = self.colorTextField.text;
        [self.dogSelect.managedObjectContext save:nil];

    }else{

        Dog *dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self. ownerSelected.managedObjectContext];
        dog.name = self.nameTextField.text;
        dog.breed = self.breedTextField.text;
        dog.color = self.colorTextField.text;
        [self.ownerSelected addDogsObject:dog];

        [self.ownerSelected.managedObjectContext save:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
