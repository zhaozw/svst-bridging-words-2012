//
//  ResultRobotTrainingViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultRobotTrainingViewController.h"

@interface ResultRobotTrainingViewController ()

@end

@implementation ResultRobotTrainingViewController
@synthesize mainMenuButtonTouch;
@synthesize resultLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setResultLabel:nil];
    [self setMainMenuButtonTouch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)replayButtonTouch:(id)sender {
    /* Get the current array of View Controllers */
    NSArray *currentControllers = self.navigationController.viewControllers;
    /* Create a mutable array out of this array */ 
    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
    /* Remove the last object from the array */ 
    [newControllers removeLastObject];
    /* Assign this array to the Navigation Controller */
    self.navigationController.viewControllers = newControllers;
}
- (IBAction)backToMainMenu:(id)sender {
    /* Get the current array of View Controllers */
    NSArray *currentControllers = self.navigationController.viewControllers;
    /* Create a mutable array out of this array */ 
    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
    /* Remove the last object from the array */ 
    [newControllers removeLastObject];
    [newControllers removeLastObject];
    /* Assign this array to the Navigation Controller */
    self.navigationController.viewControllers = newControllers;
}
@end
