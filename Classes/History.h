//
//  History.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History : NSObject
{
    NSInteger _playerKey;
    NSInteger _playerID;
    NSString *_playerName;
    NSString *_playerAvatar;
    BOOL isDetailViewHydrated;
    NSString *_wordMean;
    NSString *word;
    
}
@property (nonatomic,strong) NSString *playerName;
@property (nonatomic,readwrite) NSInteger playerKey;
@property (nonatomic,readwrite) NSInteger playerID;
@property (nonatomic,strong)  NSString *playerAvatar;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;
@property (nonatomic,strong) NSString *wordMean;
@property (nonatomic,strong) NSString *word;
//Static methods.
+ (void) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;
- (id) initWithPrimaryKey:(NSInteger) pk ;
-(NSMutableArray *) detailDataToDisplay:(NSUInteger) primaryID;
-(void) wordMeanForWord:(NSString *) wordSelected;
-(void) updateWordFromHistory :(NSString*) wordSelected;
@end
