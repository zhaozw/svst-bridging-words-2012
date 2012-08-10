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

@implementation MDDemoViewController
@synthesize myArray;

#pragma mark UIViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Messages";
    self.myArray=[NSMutableArray arrayWithObjects: 	@"Hi",
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
                  @"interesting",
                  nil];
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
    if (![textField.text length])
    return YES;
        [self.myArray addObject:textField.text];
    textField.text=nil;
  
       [textField resignFirstResponder];
       [self.tableView reloadData];  
    	    return YES;
    
}

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
  
   
    return [NSString stringWithFormat:@"%@",[self.myArray objectAtIndex:indexPath.row]];
    
 
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count= [self.myArray count];
    if(count ==0) return 1;
    else {
        return count;
    }
    
}

@end
