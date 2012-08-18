//
//  History.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "History.h"
#import <sqlite3.h>
#import "AppDelegate.h"
#define DATABASE = "bw_stories";

static sqlite3 *database = nil;
static sqlite3_stmt *detailStmt = nil;
static sqlite3_stmt *wordWithCharater=nil;
static sqlite3_stmt *wordMeanStmt=nil;
static sqlite3_stmt *selectstmt=nil;
static sqlite3_stmt *updateStmt=nil;
@implementation History
@synthesize playerName=_playerName;
@synthesize playerID=_playerID;
@synthesize playerKey=_playerKey;
@synthesize playerAvatar=_playerAvatar;
@synthesize isDetailViewHydrated;
@synthesize wordMean=_wordMean;
@synthesize word;
+ (void) getInitialDataToDisplay:(NSString *)dbPath
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        if (selectstmt==nil) {
            const char *sql = "SELECT id,playerName,playerID FROM bd_history ";
            if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
                sqlite3_bind_int(selectstmt, 1, 0);
        }	
		
		
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                
                
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				History *playersObj = [[History alloc] initWithPrimaryKey:primaryKey];
				playersObj.playerName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                playersObj.playerID = sqlite3_column_int(selectstmt, 2);
				
				
				[appDelegate.playerArr addObject:playersObj];
                
			}
		}
        
        
	}
	else
	{
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
		
	}
}
- (id) initWithPrimaryKey:(NSInteger) pk {
    
	_playerID = pk;
	
	isDetailViewHydrated = NO;
	
	return self;
}
+ (void) finalizeStatements {
	if(database) sqlite3_close(database);
    if(selectstmt) sqlite3_finalize(selectstmt);
    if(detailStmt) sqlite3_finalize(detailStmt);
    if (wordMeanStmt) sqlite3_finalize(wordMeanStmt);
    if (updateStmt  ) {
        sqlite3_finalize(updateStmt);
    }
        }
-(NSMutableArray  *) detailDataToDisplay:(NSUInteger) primaryID
{
    //if(isDetailViewHydrated) return NULL;
    NSMutableArray *listWords=[[NSMutableArray alloc]init];
    if (detailStmt==nil) {
        const char *sql = "SELECT word,word_mean FROM bd_robot WHERE player_id = ? ";
		if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
        
    }
    sqlite3_bind_int(detailStmt, 1, primaryID);
    while(sqlite3_step(detailStmt) == SQLITE_ROW) {
        [listWords addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(detailStmt, 0)]];				
    }
	//Reset the detail statement.
	sqlite3_reset(detailStmt);
	//Set isDetailViewHydrated as YES, so we do not get it again from the database.
	isDetailViewHydrated = YES;	
    return listWords;
    
}
-(void) wordMeanForWord:(NSString *) wordSelected
{
    
    if(isDetailViewHydrated) return;
	if(wordMeanStmt == nil) {
		const char *sql = "SELECT word_mean FROM bd_robot WHERE word = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &wordMeanStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
	}
	const char *abc = [wordSelected UTF8String];
	sqlite3_bind_text(wordMeanStmt, 1, abc, -1, SQLITE_TRANSIENT);	
	if(sqlite3_step(wordMeanStmt) != SQLITE_DONE ) {
		NSString *cssPath = [[NSBundle mainBundle] pathForResource:@"style" ofType:@"css"];
		NSString *cssString = [NSString stringWithContentsOfFile:cssPath];
       
		_wordMean = [NSString stringWithUTF8String:(char *)sqlite3_column_text(wordMeanStmt, 0)];
       
        
		_wordMean = [_wordMean stringByAppendingString:cssString];
        if (_wordMean==nil) {
            _wordMean=@"User hasnt put mean";
        }
	}
	else
		NSAssert1(0, @"Error while getting the content of dict. '%s'", sqlite3_errmsg(database));
	//Reset the detail statement.
	sqlite3_reset(wordMeanStmt);
	//Set isDetailViewHydrated as YES, so we do not get it again from the database.
	isDetailViewHydrated = YES;	
}
-(void) updateWordFromHistory:(NSString *)wordSelected
{
    
        
        if(updateStmt == nil) {
            const char *sql = "update bd_robot Set player_id = ? Where word = ?";
            if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK)
                NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
        }
        sqlite3_bind_int(updateStmt, 1, 0);
        sqlite3_bind_text(updateStmt, 2, [wordSelected UTF8String], -1, SQLITE_TRANSIENT);
        
        if(SQLITE_DONE != sqlite3_step(updateStmt))
            NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
        
        sqlite3_reset(updateStmt);
        
       

}

@end
