

#import "Robot.h"
#import <sqlite3.h>
#define DATABASE = "bw_stories";

static sqlite3 *database = nil;
static sqlite3_stmt *detailStmt = nil;
static sqlite3_stmt *wordWithCharater=nil;
static sqlite3_stmt *addStmt=nil;

@implementation Robot

@synthesize  word, content, isDetailViewHydrated,playerID;

+ (NSMutableArray *) getInitialDataToDisplay:(NSString *)dbPath
{
	NSMutableArray *listWord = [[NSMutableArray alloc] init];
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		const char *sql = "SELECT word FROM bd_robot where player_id=?";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
            sqlite3_bind_int(selectstmt, 1, 0);
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
							[listWord addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)]];				
			}
		}
		return listWord;
	}
	else
	{
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
		return nil;
	}
}


+ (void) finalizeStatements {
	if(database) sqlite3_close(database);
    if(addStmt) sqlite3_finalize(addStmt);
}

- (void) hydrateDetailViewData:(NSString *) wordSelected
{
	//If the detail view is hydrated then do not get it from the database.
	if(isDetailViewHydrated) return;
	if(detailStmt == nil) {
		const char *sql = "SELECT word_mean FROM bd_robot WHERE word = ? ";
		if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
	}
	const char *abc = [wordSelected UTF8String];
	sqlite3_bind_text(detailStmt, 1, abc, -1, SQLITE_TRANSIENT);	
	if(sqlite3_step(detailStmt) != SQLITE_DONE ) {

		content = [NSString stringWithUTF8String:(char *)sqlite3_column_text(detailStmt, 0)];
	}
	else
		NSAssert1(0, @"Error while getting the content of dict. '%s'", sqlite3_errmsg(database));
	//Reset the detail statement.
	sqlite3_reset(detailStmt);
	//Set isDetailViewHydrated as YES, so we do not get it again from the database.
	isDetailViewHydrated = YES;	
}
-(void) insertWordToRobot:(NSString *)wordInsert{
    if (addStmt==nil) {
        const char *sql = "insert into bd_robot(word,player_id) Values(?, ?)";
        if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    }
    sqlite3_bind_text(addStmt, 1, [wordInsert UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_double(addStmt, 2, 0);
    
    if(SQLITE_DONE != sqlite3_step(addStmt))
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        //SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
        wordID = sqlite3_last_insert_rowid(database);
    
    //Reset the add statement.
    sqlite3_reset(addStmt);

}
-(NSMutableArray *) detailViewWithCharater:(char)charBegin
{
    NSMutableArray *listRobotWord= [[NSMutableArray alloc]init];
    if(wordWithCharater == nil) {

		const char *sql = "SELECT word FROM bd_robot WHERE word LIKE ?001";
        
    if(sqlite3_prepare_v2(database, sql, -1, &wordWithCharater, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
	}
    NSString *searchInput = [NSString stringWithFormat:@"%c%%", charBegin];
    sqlite3_bind_text(wordWithCharater, 1, [searchInput UTF8String],-1,SQLITE_TRANSIENT); 
//	sqlite3_bind_text(wordWithCharater, 1, abc, -1, SQLITE_TRANSIENT);	
    while(sqlite3_step(wordWithCharater) == SQLITE_ROW) {
        [listRobotWord addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(wordWithCharater, 0)]];
        
    }
    

	//Reset the detail statement.
	sqlite3_reset(wordWithCharater);
	//Set isDetailViewHydrated as YES, so we do not get it again from the database.
	return listRobotWord;


}


@end
