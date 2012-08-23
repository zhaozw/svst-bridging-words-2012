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
static bool insertYN=true;
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
    self.currentChar = '*';
    
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
        
        [self.tableView reloadData];
        Robot *robotObj=[[Robot alloc]init];
        [self robotAnswer:currentChar];
        [self.tableView reloadData];
        if (insertYN) {
            [robotObj insertWordToRobot:word];
        }
                
        textField.text=nil;
    } 
//    else {
//        ResultRobotTrainingViewController *resultView;
//        resultView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"resultRobotTrainingView"];
//        [resultView viewErrorMsg:1];
//        [self.navigationController pushViewController:resultView animated:YES];
//        return YES;
//    }
    [textField resignFirstResponder];
     hud.labelText = @"Cheking word...";
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.arrListWord count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
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
//        Robot *robotObj=[[Robot alloc]init];
//        [robotObj deleteWordFromRobot:wrongWord];
//        ResultRobotTrainingViewController *resultView;
//        resultView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"resultRobotTrainingView"];
//        [resultView viewErrorMsg:4];
//        [self.navigationController pushViewController:resultView animated:YES];
//        return;
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



//



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
        [resultView viewErrorMsg:9];
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
