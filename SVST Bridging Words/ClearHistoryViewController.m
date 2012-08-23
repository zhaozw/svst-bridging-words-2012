//
//  ClearHistoryViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ClearHistoryViewController.h"

@interface ClearHistoryViewController ()

@end

@implementation ClearHistoryViewController
@synthesize myLabel;
@synthesize playerName;

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
-(void) viewDidAppear:(BOOL)animated
{
    self.myLabel.text=[NSString stringWithFormat:@"You have already known all of %@'s words",playerName];
    self.myLabel.font=[UIFont fontWithName:@"ChalkboardSE" size:20];
    NSLog(@"text is %@",self.myLabel.text);

   }   

- (void)viewDidUnload
{
    [self setMyLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
