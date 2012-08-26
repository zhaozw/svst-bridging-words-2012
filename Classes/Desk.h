//
//  Desk.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
@interface Desk : NSObject
{
    NSString *player1Name;
    NSInteger player1ID;
    NSString *player2Name;
    NSInteger player2ID;
    
    
}
@property (strong,nonatomic) NSString *player1Name;
@property (nonatomic,readwrite) NSInteger player1ID;
@property (strong,nonatomic) NSString *player2Name;
@property (nonatomic,readwrite) NSInteger player2ID;
@end
