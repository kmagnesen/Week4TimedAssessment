//
//  ViewController.m
//  Week4TimedAssessment
//
//  Created by Kyle Magnesen on 1/30/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "DogsViewController.h"
#import "DogOwner.h"
#import "Person.h"
#import "Color.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;

@property (nonatomic)  NSArray *dogOwners;
@property (nonatomic)  NSMutableArray *persons;
@property (nonatomic)  Color *colorFav;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Dog Owners";
    self.persons = [[NSMutableArray alloc] init];

    DogOwner *dogOwn = [[DogOwner alloc] init];

    dogOwn.moc = self.managedObjectContext;

    [dogOwn retrieveListOwnersWithCompletion:^(NSArray *dogowners) {
        self.dogOwners = dogowners;
        [self.tableView reloadData];
    }];

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Color"];
    // request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"colorRValue" ascending:YES]];
    NSError *error;

    Color *color = [self.managedObjectContext executeFetchRequest:request error:&error].lastObject;

    if (color) {
        UIColor *col = [[UIColor alloc] initWithRed:[color.colorR floatValue]  green:[color.colorG floatValue] blue:[color.colorB floatValue] alpha:[color.colorA floatValue]];

        self.navigationController.navigationBar.tintColor = col;
    }
}

#pragma mark ------------- LOAD COLOR SETTINGS AND COLOR BUTTON TAPPED ACTION -------------
-(void)loadColor{
    UIColor *c = self.navigationController.navigationBar.tintColor;
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    const CGFloat *components = CGColorGetComponents(c.CGColor);
    red = components[0];
    green = components[1];
    blue = components[2];
    alpha = components[3];

    Color *color = [NSEntityDescription  insertNewObjectForEntityForName:@"Color" inManagedObjectContext:self.managedObjectContext];
    color.colorR = [NSNumber numberWithFloat:red];
    color.colorG = [NSNumber numberWithFloat:green];
    color.colorB = [NSNumber numberWithFloat:blue];
    color.colorA = [NSNumber numberWithFloat:alpha];

    [self.managedObjectContext save:nil];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0)
    {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    }
    else if (buttonIndex == 1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    }
    else if (buttonIndex == 2)
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }
    else if (buttonIndex == 3)
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }
    else if (buttonIndex == 4)
    {
        self.navigationController.navigationBar.tintColor = [UIColor magentaColor];
    }
    else if (buttonIndex == 5)
    {
        self.navigationController.navigationBar.tintColor = [UIColor brownColor];
    }
    [self loadColor];
}

- (IBAction)colorButtonTapped:(UIBarButtonItem *)sender {
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                 message:nil
                                                delegate:self
                                       cancelButtonTitle:nil
                                       otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", @"Magenta", @"Brown", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

#pragma mark ------------- TABLEVIEW DELEGATE AND DATASOURCE -------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dogOwners.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person *owner = [self.dogOwners objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    cell.textLabel.text = owner.name;
    return cell;
}


#pragma mark ------------- PREPARE FOR SEGUE -------------

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    Person *person = [self.dogOwners objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    DogsViewController *dogsViewController = segue.destinationViewController;
    dogsViewController.personOwner  = person;
}

@end
