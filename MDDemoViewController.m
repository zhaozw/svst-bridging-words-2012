//
//  MDDemoViewController.m
//  Messages Demo
//
//  Created by Sam Soffes on 11/7/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "MDDemoViewController.h"
#import "SSMessageTableViewCell.h"
#import <Foundation/NSArray.h>
#import <Foundation/NSObject.h>
#import "Robot.h"
#import "AppDelegate.h"

@implementation MDDemoViewController
@synthesize myArray,arrListWord,arrListDictObj;

#pragma mark UIViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Messages";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   //int count=appDelegate.robotWords.count;
    //Robot *robot= [appDelegate.robotWords objectAtIndex:0];
   // NSLog(@"object at index is %@ and word mean %@", robot.word,robot.wordMean);
  //  [self.myArray addObjectsFromArray:appDelegate.robotWords];

//    self.myArray=[NSMutableArray arrayWithObjects: 	@"Hi",
//                  @"This is a work in progress",
//                  @"Ya I know",
//                  @"Fine then\nI see how it is",
//                  @"Do you? Do you really?",
//                  @"Yes",
//                  @"Daniel",
//                  @"1",
//                  @"This is a work in progress",
//                  @"Ya I know",
//                  @"Fine then\nI see how it is",
//                  @"Do you? Do you really?",
//                  @"Yes",
//                  @"Daniel",
//                  @"interesting",
//                  nil];
    
    
    self.arrListWord = [[NSMutableArray alloc] init];
	self.arrListDictObj = [[NSMutableArray alloc] init];
	
	self.arrListDictObj = [Robot getInitialDataToDisplay:[self getDBPath]];
	[self.arrListWord addObjectsFromArray:self.arrListDictObj];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
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
    //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //int count=appDelegate.robotWords.count

    if (![textField.text length])
    return YES;
    [arrListDictObj addObject:textField.text];
        //[self.myArray addObject:textField.text];
    textField.text=nil;
  
       [textField resignFirstResponder];
       [self.tableView reloadData];  
    	    return YES;
    
}

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
  
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    Robot *robot= [appDelegate.robotWords objectAtIndex:indexPath.row];

    return [NSString stringWithFormat:@"%@",[self.arrListDictObj objectAtIndex:indexPath.row]];
    
 
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSUInteger count=appDelegate.robotWords.count;
    //NSUInteger count= [self.myArray count];
    NSUInteger count=[self.arrListDictObj count];
    if(count ==0) return 1;
    else {
        return count;
    }
    
}



#pragma mark additional mothod
- (void) copyDatabaseIfNeeded {
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	if(!success) {
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"bw_stories.db"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		if (!success) 
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

- (NSString *) getDBPath {
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"bw_stories.db"];
}


@end
