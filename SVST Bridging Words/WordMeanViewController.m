//
//  WordMeanViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WordMeanViewController.h"

@interface WordMeanViewController ()

@end

@implementation WordMeanViewController

@synthesize webView;
@synthesize historyObj;

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
    self.title=historyObj.word;
	// Do any additional setup after loading the view.
}
-(void) viewDidAppear:(BOOL)animated{
	
}
- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    NSLog(@"In webview %@",historyObj.wordMean);
    //[webView loadHTMLString:@"text" baseURL:nil];
    [webView loadHTMLString:historyObj.wordMean baseURL:nil];
    webView.backgroundColor=[UIColor redColor];
    webView.autoresizesSubviews = true;

}
- (void)viewDidUnload
{
    //[self setScrollView:nil];
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)rememberButtonTouch:(id)sender {
    [historyObj updateWordFromHistory:historyObj.word];
}
@end
