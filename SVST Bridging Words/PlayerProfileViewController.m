//
//  PlayerProfileViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerProfileViewController.h"

@interface PlayerProfileViewController ()

@end

@implementation PlayerProfileViewController
@synthesize avartarImageView;
@synthesize winLabel;
@synthesize loseLabel;
@synthesize statusLabel;
@synthesize totalScoreLabel;
@synthesize numberWordsUseLabel;
@synthesize playerNameLabel;
@synthesize playerProfile;

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
-(void) viewWillAppear:(BOOL)animated
{
    if (playerProfile.status==NULL) {
        statusLabel.text=@"";
    }else {
        statusLabel.text=playerProfile.status;
        
    }
    playerNameLabel.text=playerProfile.playerName;
    winLabel.text=[NSString stringWithFormat:@"%d", playerProfile.numberWin];
    loseLabel.text=[NSString stringWithFormat:@"%d",playerProfile.numberLose];
    totalScoreLabel.text=[NSString stringWithFormat:@"%d",playerProfile.playerScore];
    numberWordsUseLabel.text=[NSString stringWithFormat:@"%d",playerProfile.numberWordsUse];
    
    
}
- (void)viewDidUnload
{
    [self setAvartarImageView:nil];
    [self setWinLabel:nil];
    [self setLoseLabel:nil];
    [self setStatusLabel:nil];
    [self setTotalScoreLabel:nil];
    [self setNumberWordsUseLabel:nil];
    [self setPlayerNameLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
