//
//  MenuViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize _laserSound;

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
    //SystemSoundID sound1;
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"laser-01"
                                              withExtension:@"aif"];
    NSString *alanSugarFilePath =
    [[NSBundle mainBundle] pathForResource:@"laser"
                                    ofType:@"aif"];
    NSLog(@"path: %@",alanSugarFilePath);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &_laserSound);
}

- (void)viewDidAppear:(BOOL)animated
{
    AudioServicesPlaySystemSound(_laserSound);
    printf("\nlaser sound played\n");
    [self.navigationController setNavigationBarHidden:NO];
    
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
