//
//  DeskListViewController.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Desk.h"
#import "Room.h"
@interface DeskListViewController : UITableViewController
{
    NSMutableArray *deskListArr;
    Desk *desk;
    Room *room;
    

}
@property (nonatomic,strong) NSMutableArray *deskListArr;
@property (nonatomic,strong) Desk *desk;
@property (nonatomic,strong)Room *room;
@end
