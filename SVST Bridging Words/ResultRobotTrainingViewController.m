//
//  ResultRobotTrainingViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultRobotTrainingViewController.h"
#import "TrainRobotViewController.h"

@interface ResultRobotTrainingViewController ()

@end

@implementation ResultRobotTrainingViewController
@synthesize mainMenuButtonTouch;
@synthesize myLabel;
@synthesize resultLabel,errorMsg;

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
    [self setMyLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void) viewDidAppear:(BOOL)animated{
    self.resultLabel.text=self.errorMsg;
    self.resultLabel.textAlignment= UITextAlignmentCenter;
    
    
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
-(void) viewErrorMsg:(NSInteger) intMsg
{
    switch (intMsg) {
        case 1:
            self.errorMsg=@" Robot has known this word";
       
            break;
        case 2:
            self.errorMsg=@"Robot has been defeated by you. Congratulation!";
        
            break;
        case 3: 
            self.errorMsg=@"You lose! \n You have enterd word twice.";
          
            break;
        case 4:
            self.errorMsg=@"You have been defeated by your robot.\n You enterd wrong word. Try again!";
          
            break;
            
            
        default: self.errorMsg=@"Game Finish!";
            break;
    }    
    
}
@end
