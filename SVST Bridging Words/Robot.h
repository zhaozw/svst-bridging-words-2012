////
////  Robot.h
////  SVST Bridging Words
////
////  Created by Mahmood1 on 8/9/12.
////  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import <sqlite3.h>
//
//@interface Robot : NSObject
//{
//
//    NSUInteger wordCount;
//    NSString *word;
//    NSString *wordMean;
//    NSUInteger wordId;
//    NSUInteger isPlayerYN;
//    
//}
//@property (strong,nonatomic) NSString *word;
//@property (strong,nonatomic) NSString *wordMean;
//-(id) initWithRobot:(NSString *)w wordMean:(NSString *) wm wordID:(NSUInteger) wid isPlayerYN:(NSUInteger)pl;
//-(id)initWithWord:(NSString*)w;
//@end
//
//  simple dictionary project
//
//  Created by khoinguonit-mac on 11/1/11.
//  Copyright 2011 __KhoiNguonIT__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface Robot : NSObject {
	NSString *word;
	NSString *content;
	BOOL isDetailViewHydrated;
}

@property (nonatomic, copy) NSString *word;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;

//Static methods.
+ (NSMutableArray *) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods.
- (void) hydrateDetailViewData:(NSString *) wordSelected;

@end
