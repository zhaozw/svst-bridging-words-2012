//
//  simple dictionary project
//
//  Created by khoinguonit-mac on 11/1/11.
//  Copyright 2011 __KhoiNguonIT__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface ListRobotWordsViewController : UITableViewController<UISearchBarDelegate> {
	
	AppDelegate *appDelegate;
    
	UINavigationController *addNavigationController;
	NSMutableArray *arrListDictObj;
	NSMutableArray *arrListWord;
	IBOutlet UITableView *theTableView;
	NSArray *searchResult;
}
- (IBAction)menuButtonTouch:(id)sender;
@property (nonatomic, retain) NSMutableArray *arrListDictObj;
@property (nonatomic, retain) NSMutableArray *arrListWord;
@property (nonatomic, retain) IBOutlet UITableView *theTableView;
@property (nonatomic, retain) NSArray *searchResult;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;
- (void) reloadTable;
@end
