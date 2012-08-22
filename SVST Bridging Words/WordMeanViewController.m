//
//  WordMeanViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WordMeanViewController.h"
#import "ListPlayerWordsViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "MBProgressHUD.h"
@interface WordMeanViewController ()

@end

@implementation WordMeanViewController

@synthesize webView;
@synthesize IBRememberBtn;
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

- (void)requestFinished:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        NSLog( @"Invalid code");        
    }
    else if (request.responseStatusCode==404){
        NSString *responseString = [request responseString];
        NSLog(@"string%@",responseString);
        NSDictionary *responseDict = [responseString JSONValue] ;
        NSArray *tweets=[[responseDict objectForKey:@"posts"] valueForKey:@"post"];
        for (NSDictionary *tweet in tweets)
        {
            NSString *url = [tweet valueForKey:@"Meaning"];
            NSLog(@"url is: %@",url);
            
        }
        
    } 
    else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        NSLog(@"%@",responseString);
        NSDictionary *responseDict = [responseString JSONValue] ;
        NSArray *tweets=[[responseDict objectForKey:@"posts"] valueForKey:@"post"];
        for (NSDictionary *tweet in tweets)
        {
            NSString *url = [tweet valueForKey:@"Meaning"];
            NSLog(@"url is: %@",url);
            historyObj.wordMean=url;
            [webView loadHTMLString:historyObj.wordMean baseURL:nil];
            webView.autoresizesSubviews = true;
            [self viewWillAppear:YES];
        }
        
    } else {
        NSLog(@"Unexpected error");
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSError *error = [request error];
    NSLog(error.localizedDescription);
}

-(void) viewDidAppear:(BOOL)animated{
    [webView loadHTMLString:historyObj.wordMean baseURL:nil];
    webView.autoresizesSubviews = true;
}
- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    if (historyObj.wordMean==@"") {
        NSURL *url = [NSURL URLWithString:@"http://bobbymistery.byethost11.com/bw/"];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        NSString *word=historyObj.word;
        [request setPostValue:word forKey:@"word"];
        [request setDelegate:self];
        [request startAsynchronous];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Updating Meaning...";

      }
    
    NSLog(@"In webview %@",historyObj.wordMean);
    //[webView loadHTMLString:@"text" baseURL:nil];


}
- (void)viewDidUnload
{
    //[self setScrollView:nil];
    [self setWebView:nil];
    [self setIBRememberBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)rememberButtonTouch:(id)sender {
    [historyObj updateWordFromHistory:historyObj.word];
    [historyObj updateWordFromRobot:historyObj.word Mean:historyObj.wordMean];
}
@end
