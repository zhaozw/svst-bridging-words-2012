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

@interface TrainRobotViewController : SSMessagesViewController<UITextFieldDelegate> {
    NSMutableArray *myArray;
	NSMutableArray *arrListDictObj;
	NSMutableArray *arrListWord;
    ResultRobotTrainingViewController *rsView;
    UILabel *_labelRobotCount;
    UIImageView *_imageRobotCount;
    NSMutableArray *arrListWrongWords;
    
    
}
@property (strong,nonatomic) NSMutableArray *arrListWrongWords;
@property(strong,nonatomic) NSMutableArray *myArray;
@property (nonatomic, retain) NSMutableArray *arrListDictObj;
@property (nonatomic, retain) NSMutableArray *arrListWord;
@property (strong,nonatomic) ResultRobotTrainingViewController *rsView;
@property (nonatomic,retain) UILabel *labelRobotCount;
@property char currentChar;
@property (nonatomic,retain) UIImageView *imageRobotCount;
@property (strong, nonatomic) SoundHelper* soundHelper;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;
-(void) drawLabelCount;

@end
