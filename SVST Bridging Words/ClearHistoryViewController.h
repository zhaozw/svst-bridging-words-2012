//
//  ClearHistoryViewController.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClearHistoryViewController : UIViewController
{
    NSString *playerName;

}
@property (strong, nonatomic) IBOutlet UILabel *myLabel;
@property (strong,nonatomic) NSString *playerName;
@end
