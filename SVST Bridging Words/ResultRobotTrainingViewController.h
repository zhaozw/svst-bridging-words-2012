//
//  ResultRobotTrainingViewController.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultRobotTrainingViewController : UIViewController
{
    NSString *errorMsg;
}
@property (nonatomic,strong) NSString *errorMsg;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
- (IBAction)replayButtonTouch:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *mainMenuButtonTouch;
- (IBAction)backToMainMenu:(id)sender;
-(void) viewErrorMsg:(NSInteger) intMsg;
@end
