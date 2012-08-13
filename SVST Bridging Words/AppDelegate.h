//
//  AppDelegate.h
//  SQLTEST
//
//  Created by Mahmood1 on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface AppDelegate :   NSObject
{
    
    UIWindow *window;
    
    
	// Database variables
	NSString *databaseName;
	NSString *databasePath;
    
	// Array to store the animal objects
	NSMutableArray *stories;
    NSUInteger *wordCount;
    NSMutableArray *robotWords;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) NSMutableArray *stories;
@property (strong,nonatomic) NSMutableArray *robotWords;
- (NSString *) getDBPath ;
- (void) copyDatabaseIfNeeded ;
@end
