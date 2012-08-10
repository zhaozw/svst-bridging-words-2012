//
//  ViewController.m
//  SQLTEST
//
//  Created by Mahmood1 on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Stories.h"
#import "SelfPlayViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myTextView;
@synthesize counterLabel;
@synthesize counter;


- (void)viewDidLoad
{
       [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    int ranMax=appDelegate.stories.count;
    Stories *story=[appDelegate.stories objectAtIndex:[self randomValue:ranMax]];
    
    self.myTextView.text= story.content;
    self.myTextView.editable=NO;

    self.counter = 3;
    [self countDown];
}

- (void)countDown
{
    self.counterLabel.text = [NSString stringWithFormat:@"%d",self.counter];
    if (self.counter == 0) {
        [self startSelfPlay];
    } else {
        self.counter --;
        [self performSelector:@selector(countDown) withObject:nil afterDelay:1];
    }
}

- (void)startSelfPlay
{
    SelfPlayViewController *selfPlayView;
    selfPlayView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"selfPlayView"];
    selfPlayView.story = [self.myTextView.text lowercaseString];
    [self.navigationController pushViewController:selfPlayView animated:YES];
}

//generate random value
-(unsigned int) randomValue:(NSInteger)ranMax
{
    unsigned int randomNumber = 
    arc4random() % ranMax;
    return randomNumber;
    
}

- (void)viewDidUnload
{
    [self setMyTextView:nil];
    [self setMyTextView:nil];
    [self setCounterLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//- (void)dealloc {
////    [myTextView release];
////    [super dealloc];
//}
@end
