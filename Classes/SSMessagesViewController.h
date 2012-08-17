//
//  SSMessagesViewController.h
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//
//	This is an abstract class for displaying a UI similar to Apple's SMS application. A subclass should override the
//  messageStyleForRowAtIndexPath: and textForRowAtIndexPath: to customize this class.
//

#import "SSMessageTableViewCell.h"

@class SSTextField;

@interface SSMessagesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {

@private
	
    UIView *_tableHeaderView;
    UITextField *_textFieldView;
	UITableView *_tableView;
    CGPoint tableViewContentOffset;
	UIImageView *_inputBackgroundView;
    UIImageView *_imageRobotCount;
    UILabel *_labelRobotCount;
	SSTextField *_textField;
    UIButton *_cameraButton;
	UIButton *_sendButton;
	
	UIImage *_leftBackgroundImage;
	UIImage *_rightBackgroundImage;
    NSMutableArray *wordArr;
 
    
}
@property (nonatomic,retain) UIImageView *imageRobotCount;
@property (nonatomic,retain) UILabel *labeRobotCount;
@property (nonatomic,retain) NSMutableArray *wordArr;
@property (nonatomic, retain) UIView *tableHeaderView;
@property (nonatomic, retain, readonly) UITableView *tableView;
@property (nonatomic,retain) UITextField *textFieldView;
@property (nonatomic) CGPoint tableViewContentOffset;
@property (nonatomic, retain, readonly) UIImageView *inputBackgroundView;
@property (nonatomic, retain, readonly) SSTextField *textField;
@property (nonatomic, retain, readonly) UIButton *cameraButton;
@property (nonatomic, retain, readonly) UIButton *sendButton;
@property (nonatomic, retain) UIImage *leftBackgroundImage;
@property (nonatomic, retain) UIImage *rightBackgroundImage;

- (SSMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)detailTextForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)detailTextColorForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)detailBackgroundColorForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
