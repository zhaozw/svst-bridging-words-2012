//
//  FriendsListViewController.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
enum flagType {
    UnreadyFlag = 1,
    ReadyFlag = 2
    };
#import <UIKit/UIKit.h>

@interface FriendsListViewController : UITableViewController
{
    NSMutableArray *listFriend;
    BOOL isReady;
}
@property (strong,nonatomic) NSMutableArray *listFriend;
@property (nonatomic,readwrite) BOOL isReady;
@end
