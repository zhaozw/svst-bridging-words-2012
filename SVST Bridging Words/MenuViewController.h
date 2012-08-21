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

@interface MenuViewController : UIViewController

@property (strong, nonatomic) SoundHelper *audioPlayer;

@end
