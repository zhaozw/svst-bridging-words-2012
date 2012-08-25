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
    Player *playerOne;
    Player *playerTwo;
}
@property (strong,nonatomic) Player *playerOne;
@property (strong,nonatomic) Player *playerTwo;
@end
