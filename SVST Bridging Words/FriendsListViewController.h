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
#import "Player.h"
#import "ASIHTTPRequest.h"
@interface FriendsListViewController : UITableViewController
{
    NSMutableArray *listFriendObj;
    Player *friendObj;
    BOOL isReady;
}
@property (strong,nonatomic) NSMutableArray *listFriendObj;
@property (strong,nonatomic) Player *friendObj;
@property (nonatomic,readwrite) BOOL isReady;
@property (nonatomic, strong) ASIHTTPRequest *myRequest;
- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;
@end
