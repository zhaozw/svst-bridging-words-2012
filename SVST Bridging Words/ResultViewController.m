//
//  ResultViewController.m
//  Bridging Words
//
//  Created by Mahmood1 on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize resultLabel;
@synthesize resultString;
@synthesize timeScore;
@synthesize wordScore;

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
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.resultLabel.text = [NSString stringWithFormat:@"Word score: %d\nTime score: %d\n Total score: %d",self.wordScore,self.timeScore,self.timeScore+self.wordScore];
}

- (void)viewDidUnload
{
    [self setResultLabel:nil];
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
    [newControllers removeLastObject];
    /* Assign this array to the Navigation Controller */
    self.navigationController.viewControllers = newControllers;
}

- (IBAction)menuButtonTouch:(id)sender {
    /* Get the current array of View Controllers */
    NSArray *currentControllers = self.navigationController.viewControllers;
    /* Create a mutable array out of this array */ 
    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
    /* Remove the last object from the array */ 
    [newControllers removeLastObject];
    [newControllers removeLastObject];
    [newControllers removeLastObject];
    /* Assign this array to the Navigation Controller */
    self.navigationController.viewControllers = newControllers;
}
@end
