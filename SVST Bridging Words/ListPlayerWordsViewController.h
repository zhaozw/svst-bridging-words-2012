//
//  ListPlayerWordsViewController.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListPlayerWordsViewController : UITableViewController
{
    NSMutableArray *myArray;
    NSMutableArray *arrListWords;
}
@property (nonatomic,strong) NSMutableArray *myArray;
@property (nonatomic,strong) NSMutableArray *arrListWords;
@end
