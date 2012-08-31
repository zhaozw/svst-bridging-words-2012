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
@synthesize gameScoreLabel;
@synthesize timeScoreLabel;
@synthesize totalScoreLabel;
@synthesize titleLabel;
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
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
//    self.resultLabel.text = [NSString stringWithFormat:@"Word score: %d\nTime score: %d\n Total score: %d",self.wordScore,self.timeScore,self.timeScore+self.wordScore];
    self.totalScoreLabel.text = [NSString stringWithFormat:@"%d",self.wordScore];
    self.gameScoreLabel.text = [NSString stringWithFormat:@"%d",self.wordScore];
    self.timeScoreLabel.text = [NSString stringWithFormat:@"%d",self.timeScore];
    printf("Total score: %d\n",self.wordScore+self.timeScore);
    [self updateResult];
    
//    [UIView beginAnimations:@"Zoom" context:NULL];
//    [UIView setAnimationDuration:0.5];
//    self.titleLabel.frame = CGRectMake(0.0f, 0.0f, 280.0f, 50.0f);
//    [UIView commitAnimations];
}

- (void)updateResult
{
    if (self.timeScore >= 0) {
        self.timeScoreLabel.text = [NSString stringWithFormat:@"%d",self.timeScore];
        self.totalScoreLabel.text = [NSString stringWithFormat:@"%d",self.wordScore];
        self.timeScore --;
        self.wordScore ++;
        [self performSelector:@selector(updateResult) withObject:nil afterDelay:0.05];
    } else {
        printf("Timescore: %d\n", self.timeScore);
    }
}

- (void)viewDidUnload
{
    [self setResultLabel:nil];
    [self setGameScoreLabel:nil];
    [self setTimeScoreLabel:nil];
    [self setTotalScoreLabel:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)replayButtonTouch:(id)sender {
    if (self.timeScore == -1) {
        /* Get the current array of View Controllers */
        NSArray *currentControllers = self.navigationController.viewControllers;
        /* Remove the last object from the array */ 
        [self.navigationController popToViewController:[currentControllers objectAtIndex:2] animated:YES];
    }
}

- (IBAction)menuButtonTouch:(id)sender {
    if (self.timeScore == -1) {
        /* Get the current array of View Controllers */
        NSArray *currentControllers = self.navigationController.viewControllers;
        [self.navigationController popToViewController:[currentControllers objectAtIndex:1] animated:YES];
    }
}
@end
