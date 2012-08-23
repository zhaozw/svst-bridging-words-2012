//
//  PlayerProfileViewController.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
@interface PlayerProfileViewController : UIViewController
{
    Player *playerProfile;

}
@property (strong,nonatomic) Player *playerProfile;
@property (strong, nonatomic) IBOutlet UIImageView *avartarImageView;
@property (strong, nonatomic) IBOutlet UILabel *winLabel;
@property (strong, nonatomic) IBOutlet UILabel *loseLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberWordsUseLabel;

@end
