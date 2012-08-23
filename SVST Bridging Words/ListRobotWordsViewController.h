//
//  ListRobotWordsViewController.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListRobotWordsViewController : UITableViewController
{
    NSMutableArray  *arrListWords;

}
@property (strong,nonatomic) NSMutableArray *arrListWords;

@end
