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
