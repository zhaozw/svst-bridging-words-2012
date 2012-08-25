//
//  DeskViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DeskViewController.h"

@implementation DeskViewController
@synthesize winNumberPlayer2Label;
@synthesize loseNumberPlayer2Label;
@synthesize player2NameLabel;
@synthesize tabToStartLabel;
@synthesize player1View;
@synthesize player2View;
@synthesize loseNumberPlayer1Label;
@synthesize winNumberPlayer1Label;
@synthesize player1NameLabel;
@synthesize player1,player2;

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
    self.player1View.center = CGPointMake(-160, self.player1View.center.y);
    self.player2View.center = CGPointMake(320+160, self.player2View.center.y);
}

- (void)viewDidAppear:(BOOL)animated
{
    [UIView beginAnimations:@"player1Comein" context:NULL];
    [UIView setAnimationDuration:1];
    self.player1View.center = CGPointMake(self.player1View.bounds.size.width/2, self.player1View.center.y);
    [UIView commitAnimations];
    [self performSelector:@selector(player2ComeinAnimate) withObject:nil afterDelay:5];
}

- (void)player2ComeinAnimate
{
    [UIView beginAnimations:@"player2Comein" context:NULL];
    [UIView setAnimationDuration:1];
    self.player2View.center = CGPointMake(self.player2View.bounds.size.width/2, self.player2View.center.y);
    [UIView commitAnimations];
}

- (void)viewDidUnload
{
    [self setPlayer1NameLabel:nil];
    [self setWinNumberPlayer1Label:nil];
    [self setLoseNumberPlayer1Label:nil];
    [self setWinNumberPlayer2Label:nil];
    [self setLoseNumberPlayer2Label:nil];
    [self setPlayer2NameLabel:nil];
    [self setTabToStartLabel:nil];
    [self setPlayer1View:nil];
    [self setPlayer2View:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
