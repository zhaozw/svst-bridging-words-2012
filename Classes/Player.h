//
//  Player.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject
{
    NSString *playerID;
    NSString *playerName;
    NSInteger age;
    NSString *sex;
    NSString *email;
    NSString *robotName;
    NSString *userName;
    NSString *passWord;
    NSInteger numberWin;
    NSInteger numberLose;
    NSInteger stt;
    NSString *status;
    NSInteger playerScore;
    NSInteger numberWordsUse;
    NSInteger inRoomNumber;
    BOOL isPlayerReady;
}
@property (nonatomic,readwrite) NSInteger inRoomNumber;
@property (nonatomic,readwrite) NSInteger numberWordsUse;
@property (nonatomic,readwrite) NSInteger playerScore;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,readwrite) NSInteger numberWin;
@property (nonatomic,readwrite) NSInteger numberLose;
@property (nonatomic,readwrite) NSInteger stt;
@property (nonatomic,strong) NSString *playerID;
@property (nonatomic,strong) NSString *playerName;
@property (nonatomic,readwrite) NSInteger age;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *robotName;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *passWord;
@property (nonatomic,readwrite) BOOL isPlayerReady;

@end
