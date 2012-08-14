//
//  ResultViewController.h
//  Bridging Words
//
//  Created by Mahmood1 on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property NSString *resultString;
@property NSInteger wordScore;
@property NSInteger timeScore;

- (IBAction)replayButtonTouch:(id)sender;
- (IBAction)menuButtonTouch:(id)sender;

@end
