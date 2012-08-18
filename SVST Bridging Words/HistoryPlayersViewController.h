//
//  HistoryPlayersViewController.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface HistoryPlayersViewController : UITableViewController
{
    AppDelegate *appDelegate;

}
@property (nonatomic,strong) NSMutableArray *arrListPlayerObj;
@property (nonatomic,strong) NSMutableArray *arrListPlayers;

@end
