//
//  MDDemoViewController.h
//  Messages Demo
//
//  Created by Sam Soffes on 11/7/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSMessagesViewController.h"
#import "ResultRobotTrainingViewController.h"
#import "SoundHelper.h"

@interface InGameViewController : SSMessagesViewController<UITextFieldDelegate> {
    NSMutableArray *myArray;
	NSMutableArray *arrListDictObj;
	NSMutableArray *arrListWord;
    ResultRobotTrainingViewController *rsView;
    UILabel *player1Info;
    UILabel *player2Info;
    UILabel *player1Score;
    UILabel *player2Score;
    UIImageView *_imageRobotCount;
    
    
}
@property(strong,nonatomic) NSMutableArray *myArray;
@property (nonatomic, retain) NSMutableArray *arrListDictObj;
@property (nonatomic, retain) NSMutableArray *arrListWord;
@property (strong,nonatomic) ResultRobotTrainingViewController *rsView;
@property (nonatomic,retain) UILabel *player1Info;
@property (nonatomic,retain) UILabel *player2Info;
@property (nonatomic,retain) UILabel *player1Score;
@property (nonatomic,retain) UILabel *player2Score;
@property char currentChar;
@property (nonatomic,retain) UIImageView *imageRobotCount;
@property (strong, nonatomic) SoundHelper* soundHelper;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;
-(void) drawLabelCount;

@end
