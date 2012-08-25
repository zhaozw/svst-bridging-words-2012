//
//  TrainRobotViewController.m
//  Messages Demo
//
//  Created by Sam Soffes on 11/7/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "TrainRobotViewController.h"
#import "SSMessageTableViewCell.h"
#import <Foundation/NSArray.h>
#import <Foundation/NSObject.h>
#import "Robot.h"
#import "AppDelegate.h"
#import "ResultRobotTrainingViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "MBProgressHUD.h"
#define TABLEVIEWTAG	300
@implementation TrainRobotViewController
@synthesize myArray,arrListWord,arrListDictObj;
@synthesize currentChar;
@synthesize rsView;
@synthesize labelRobotCount=_labelRobotCount;
@synthesize imageRobotCount=_imageRobotCount;
static bool insertYN=true;
static int numberRobotWords;
#pragma mark UIViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Messages";
    
    self.arrListDictObj= [[NSMutableArray alloc]init];   
    self.arrListWord = [[NSMutableArray alloc] init];
    //    self.arrListWrongWords=[[NSMutableArray alloc]init];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
    AppDelegate *appDelegate =[[AppDelegate alloc]init];  
    self.arrListDictObj = [Robot getInitialDataToDisplay:[appDelegate getDBPath]];
    numberRobotWords=[self.arrListDictObj count];
    self.currentChar = '*';
    [self drawLabelCount];
}
-(void) drawLabelCount
{
    CGSize size = self.view.frame.size;
    
    //Word Robot count
    //CGSize size = self.view.frame.size;
    _imageRobotCount=[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 10.0f, size.width, 55.0f)];
    _imageRobotCount.image=[UIImage imageNamed:@"backgroundTextField.png"];
    [self.view addSubview:_imageRobotCount];
    _labelRobotCount=[[UILabel alloc]initWithFrame:CGRectMake(0.0f, 20.0f, size.width, 25.0f)];
    _labelRobotCount.text=[NSString stringWithFormat:@"Your robot has %d words",numberRobotWords];
    _labelRobotCount.textColor=[UIColor whiteColor];
    _labelRobotCount.backgroundColor=[UIColor clearColor];
    _labelRobotCount.textAlignment=UITextAlignmentCenter;
    [self.view addSubview:_labelRobotCount];
    
    
    
}

-(unsigned int) randomValue:(NSInteger)ranMax
{
    unsigned int randomNumber = arc4random() % ranMax;
    return randomNumber;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return NO;
}


#pragma mark SSMessagesViewController

- (SSMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row % 2) {
		return SSMessageStyleRight;
	}
	return SSMessageStyleLeft;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{	
    if (![textField.text length]){
        [textField resignFirstResponder];
        return YES;
    }
    
    NSString *word = textField.text;
    
    // Start request
    NSURL *url = [NSURL URLWithString:@"http://bobbymistery.byethost11.com/bw/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:word forKey:@"word"];
    [request setDelegate:self];
    [request startAsynchronous];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Check word
    if ([self checkValidWord:word]) {
        [self.arrListWord addObject:word];
        insertYN=true;
        [self.tableView reloadData];
        Robot *robotObj=[[Robot alloc]init];
        [self robotAnswer:currentChar];
        [self.tableView reloadData];
        if (insertYN) {
            [robotObj insertWordToRobot:word];
            numberRobotWords=numberRobotWords+1;
        }
        
        textField.text=nil;
    } 
    
    [textField resignFirstResponder];
    hud.labelText = @"Cheking word...";
    [self drawLabelCount];
    return YES;
    
}
//JSON connection


- (void)requestFinished:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        NSLog( @"Invalid code");        
    }
    else if (request.responseStatusCode==404){
        insertYN=false;
        NSString *wrongWord =[[NSString alloc]init];
        if ([self.arrListWord count]>1) {
            
            wrongWord=[self.arrListWord objectAtIndex:([self.arrListWord count]-2)];}
        ResultRobotTrainingViewController *resultView=[[ResultRobotTrainingViewController alloc]init];
        [resultView.arrListWrongWords addObject:wrongWord];
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



-(void)robotAnswer:(char)charBegin
{
    Robot *robotObj=[[Robot alloc]init];
    NSMutableArray *testArr= [robotObj detailViewWithCharater:charBegin];
    int countArr=testArr.count;
    if (countArr==0) {
        ResultRobotTrainingViewController *resultView;
        resultView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"resultRobotTrainingView"];
        [resultView viewErrorMsg:2];
        [self.navigationController pushViewController:resultView animated:YES];
        return;
    }
    NSString *robotAns=[testArr objectAtIndex:[self randomValue:countArr]];
    // NSLog(@"index of object %@ is %d",robotAns,[self.arrListWord indexOfObject:robotAns]);
    if ([self checkExistWord:robotAns]) {
        [self.arrListWord addObject:robotAns];
        currentChar= [self lastCharacter:robotAns];
        NSLog(@" content robot %@",[testArr objectAtIndex:0]);
        insertYN=true;
        [self.tableView reloadData];
        
    }
    else 
    {
        ResultRobotTrainingViewController *resultView;
        resultView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"resultRobotTrainingView"];
        [resultView viewErrorMsg:2];
        [self.navigationController pushViewController:resultView animated:YES];
        insertYN=false;
        return;
    }
    
}

-(BOOL)checkValidWord:(NSString *)word
{
    if ([self checkWordCharacter:word] == false) {
        
        return false;
    }
    if (self.currentChar != '*') {
        if ([word characterAtIndex:0]!=self.currentChar) {
            
            
            ResultRobotTrainingViewController *resultView;
            resultView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"resultRobotTrainingView"];
            [resultView viewErrorMsg:4];
            [self.navigationController pushViewController:resultView animated:YES];
            return false;
        }
    }
    if ([self.arrListDictObj containsObject:word]) {
        
        
        ResultRobotTrainingViewController *resultView;
        resultView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"resultRobotTrainingView"];
        [resultView viewErrorMsg:1];
        [self.navigationController pushViewController:resultView animated:YES];
        [self viewDidUnload];
        return false;
    }
    if ([self.arrListWord containsObject:word]) {
        ResultRobotTrainingViewController *resultView;
        resultView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"resultRobotTrainingView"];
        [resultView viewErrorMsg:3];
        [self.navigationController pushViewController:resultView animated:YES];
        
        return false;
    }
    self.currentChar = [self lastCharacter:word];
    return true;
}
-(BOOL)checkExistWord:(NSString *)wordInput
{
    
    if ([self.arrListWord containsObject:wordInput]) {
        
        return false;
    }
    return true;
    
}
-(char)lastCharacter:(NSString*)word
{
    return [word characterAtIndex:[word length]-1];
}
-(BOOL)checkWordCharacter:(NSString*)word
{
    for (NSInteger i=0; i<[word length]; i++) {
        char c = [word characterAtIndex:i];
        if (c<'a'||c>'z') {
            if (c<'A'||c>'Z')
            {
                return false;
            }
        }
    }
    return true;
}

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.arrListWord.count==0) {
        return NULL;
    }
    return [NSString stringWithFormat:@"%@",[self.arrListWord objectAtIndex:indexPath.row]];
    
    
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    NSUInteger count=appDelegate.robotWords.count;
    //NSUInteger count= [self.myArray count];
    NSUInteger count=[self.arrListWord count];
    if(count ==0) return 0;
    else {
        return count;
    }
    
}



#pragma mark additional mothod


@end
