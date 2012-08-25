//
//  DeskViewController.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface DeskViewController : UIViewController
{
    Player *player1;
    Player *player2;

}
@property (strong, nonatomic) IBOutlet UILabel *loseNumberPlayer1Label;
@property (strong, nonatomic) IBOutlet UILabel *winNumberPlayer1Label;
@property (nonatomic,strong) Player *player1;
@property (strong, nonatomic) IBOutlet UILabel *player1NameLabel;
@property (nonatomic,strong) Player *player2;
@property (strong, nonatomic) IBOutlet UILabel *winNumberPlayer2Label;
@property (strong, nonatomic) IBOutlet UILabel *loseNumberPlayer2Label;
@property (strong, nonatomic) IBOutlet UILabel *player2NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tabToStartLabel;
@property (strong, nonatomic) IBOutlet UIView *player1View;
@property (strong, nonatomic) IBOutlet UIView *player2View;
@end
