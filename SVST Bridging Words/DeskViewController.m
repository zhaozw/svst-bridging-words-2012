//
//  DeskViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DeskViewController.h"
#import "InGameViewController.h"
@implementation DeskViewController
@synthesize winNumberPlayer2Label;
@synthesize loseNumberPlayer2Label;
@synthesize readyButtonIB;
@synthesize player2NameLabel;
@synthesize tabToStartLabel;
@synthesize player1View;
@synthesize player2View;
@synthesize readyLabel;
@synthesize flagPlayer2;
@synthesize flagPlayer1;
@synthesize loseNumberPlayer1Label;
@synthesize winNumberPlayer1Label;
@synthesize player1NameLabel;
@synthesize player1,player2;
@synthesize desk;

static bool isReadyToPlay=false;
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
    readyLabel.hidden=YES;
    readyButtonIB.hidden=YES;
    
   
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.desk.player1Name==@"") {
        
        self.player2NameLabel.text=self.desk.player2Name;
        [self performSelector:@selector(player1ComeinAnimate) withObject:nil afterDelay:5];
    }
    else {
        self.player1NameLabel.text=self.desk.player1Name;
        
        [UIView beginAnimations:@"player1Comein" context:NULL];
        [UIView setAnimationDuration:1];
        self.player1View.center = CGPointMake(self.player1View.bounds.size.width/2, self.player1View.center.y);
        [UIView commitAnimations];
        [self performSelector:@selector(player2ComeinAnimate) withObject:nil afterDelay:5];
    
    }
  
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
    [self setFlagPlayer1:nil];
    [self setFlagPlayer2:nil];
    [self setReadyLabel:nil];
    [self setReadyButtonIB:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)tabTheFlagButtonTouch:(id)sender {
    if (player1NameLabel.text==@"You") {
        flagPlayer1.image=[UIImage imageNamed:@"flag_ready.png"];
        player1.isPlayerReady=YES;
    }
    else {
        flagPlayer2.image=[UIImage imageNamed:@"flag_ready.png"];
        player2.isPlayerReady=YES;
    }
    //Will Remove 
    player2.isPlayerReady=YES;
    flagPlayer2.image=[UIImage imageNamed:@"flag_ready.png"];
    tabToStartLabel.hidden=YES;
    readyButtonIB.hidden=NO;
    readyLabel.hidden=NO;
   
}
- (IBAction)readyButtonTouch:(id)sender {
   // if (self.player1.isPlayerReady==YES && self.player2.isPlayerReady==YES) {
        InGameViewController *inGameView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"inGameView"];
        
        [self.navigationController pushViewController:inGameView animated:YES];
        
    
}
@end
