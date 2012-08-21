//
//  SoundHelper.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

static float audioPlayerVolume = 1;
@interface SoundHelper : NSObject <AVAudioPlayerDelegate>
{
}
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

- (void) playSound:(NSString*)name ofType:(NSString*)type;
- (BOOL) setVolume:(float)vol;

@end