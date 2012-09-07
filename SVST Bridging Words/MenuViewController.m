//
//  MenuViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "MBProgressHUD.h"
@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize audioPlayer;
@synthesize menuRequest;

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
    
    self.audioPlayer = [[SoundHelper alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    [self.audioPlayer playSound:@"Electrical_Sweep" ofType:@"mp3"];
    NSURL *url = [NSURL URLWithString:@"http://bobbymistery.byethost11.com/bw/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"0" forKey:@"USER_OFF_ID"];
    [request setDelegate:self];
    [request startAsynchronous];
    self.menuRequest=request;
    //[self.audioPlayer setVolume:1];
}
-(void)viewWillDisappear:(BOOL)animated

{
    [self.menuRequest setDelegate:nil];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        NSLog( @"Invalid code");        
    }
    else if (request.responseStatusCode == 403) {
        NSLog(@"Code already used");
    } else if (request.responseStatusCode == 200) {
     
        
    } else {
        NSLog(@"Unexpected error");
    }
        
}

- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSError *error = [request error];
    NSLog(@"%@",error.localizedDescription);
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
