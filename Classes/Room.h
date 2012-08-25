//
//  Room.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Room : NSObject
{
    NSString *roomName;
    NSInteger roomAmount;
    NSInteger roomID;
    
}
@property (strong,nonatomic) NSString * roomName;
@property (nonatomic,readwrite) NSInteger roomAmount;
@property (nonatomic,readwrite) NSInteger roomID;
@end
