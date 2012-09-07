//
//  MenuViewController.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SoundHelper.h"
#import "ASIHTTPRequest.h"

@interface MenuViewController : UIViewController
@property (strong,nonatomic) ASIHTTPRequest *menuRequest;
@property (strong, nonatomic) SoundHelper *audioPlayer;
- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;
@end
