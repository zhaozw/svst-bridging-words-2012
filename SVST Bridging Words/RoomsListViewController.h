//
//  RoomsListViewController.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"
@interface RoomsListViewController : UITableViewController
{
    Room *room;
    NSMutableArray *roomListArray;

}
@property (strong,nonatomic) NSMutableArray *roomListArray;
@property (strong,nonatomic) Room *room;

@end
