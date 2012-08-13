//
//  Stories.h
//  SQLTEST
//
//  Created by Mahmood1 on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stories : NSObject
{
    NSString *content;
}
@property (nonatomic,retain) NSString *content;
+ (NSMutableArray *) getInitialDataToDisplay:(NSString *)dbPath;
@end
