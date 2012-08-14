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

@implementation TrainRobotViewController
@synthesize myArray,arrListWord,arrListDictObj;
@synthesize currentChar;

static bool insertYN=true;
#pragma mark UIViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Messages";
    
    self.arrListDictObj= [[NSMutableArray alloc]init];   
    self.arrListWord = [[NSMutableArray alloc] init];
   
       
   }

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
     AppDelegate *appDelegate =[[AppDelegate alloc]init];  
    self.arrListDictObj = [Robot getInitialDataToDisplay:[appDelegate getDBPath]];
	int ranMax=self.arrListDictObj.count;
    [self.arrListWord addObject:[self.arrListDictObj objectAtIndex:[self randomValue:ranMax]]];
    self.currentChar = '*';
    Robot *robotObj=[[Robot alloc]init];
    NSMutableArray *testArr= [robotObj detailViewWithCharater:'h'];
    
    NSLog(@" content robot %@",[testArr objectAtIndex:0]);

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
    // Check word
    if ([self checkValidWord:word]) {
        [self.arrListWord addObject:word];
        Robot *robotObj=[[Robot alloc]init];
        [self.tableView reloadData];
        [self robotAnswer:currentChar];
        if (insertYN) {
             [robotObj insertWordToRobot:word];
        }
       
          textField.text=nil;
    } else {
        ResultRobotTrainingViewController *resultView;
        resultView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"resultRobotTrainingView"];
        [resultView viewErrorMsg:1];
        [self.navigationController pushViewController:resultView animated:YES];
    }
    [textField resignFirstResponder];
    return YES;
    
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
        [resultView viewErrorMsg:4];
        [self.navigationController pushViewController:resultView animated:YES];
        insertYN=false;
    }
       
}

-(BOOL)checkValidWord:(NSString *)word
{

    if ([self checkWordCharacter:word] == false) {
       
        return false;
    }
    if (self.currentChar != '*') {
        if ([word characterAtIndex:0]!=self.currentChar) {
         
            return false;
        }
    }
    if ([self.arrListDictObj containsObject:word]) {
      
        return false;
    }
    if ([self.arrListWord containsObject:word]) {
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
        return @"";
    }
    return [NSString stringWithFormat:@"%@",[self.arrListWord objectAtIndex:indexPath.row]];
    
 
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSUInteger count=appDelegate.robotWords.count;
    //NSUInteger count= [self.myArray count];
    NSUInteger count=[self.arrListWord count];
    if(count ==0) return 1;
    else {
        return count;
    }
    
}



#pragma mark additional mothod


@end
