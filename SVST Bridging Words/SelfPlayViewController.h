//
//  SelfPlayViewController.h
//  Bridging Words
//
//  Created by Mahmood1 on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfPlayViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *wordTextField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *bridgeView;
@property (strong, nonatomic) IBOutlet UIView *currentContainer;
@property (strong, nonatomic) IBOutlet UIProgressView *timeProgressView;

- (IBAction)finishButtonTouch:(id)sender;
@property BOOL _startBridge;
@property NSInteger counter;
@property BOOL _countdown;
@property NSInteger score;
@property NSInteger scoreLevel;
@property char currentCharacter;
@property NSString *story;

- (IBAction)addButtonTouch:(id)sender;
- (IBAction)newBridgeButtonTouch:(id)sender;

@end
