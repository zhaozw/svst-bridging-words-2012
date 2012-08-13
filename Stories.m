//
//  Stories.m
//  SQLTEST
//
//  Created by Mahmood1 on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Stories.h"
#import <sqlite3.h>
@implementation Stories
@synthesize content;

+ (NSMutableArray *) getInitialDataToDisplay:(NSString *)dbPath
{
    sqlite3 *database;    
    NSMutableArray *stories = [[NSMutableArray alloc] init];
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access from table stories
		const char *sqlStatementStories = "select * from bd_stories";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatementStories, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSString *aContent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				// Create a new story object with the data from the database
			
				[stories addObject:aContent];
                
            }
            return stories;
		} else {
            printf("%s\n",sqlite3_errmsg(database));
        }
        
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
        
             
        sqlite3_close(database);
	} else {
        printf("Error in opening database\n");
    }
	


}
@end
