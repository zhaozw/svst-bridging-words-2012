//
//  SoundHelper.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SoundHelper.h"

@implementation SoundHelper
@synthesize audioPlayer;

- (void) playSound:(NSString*)name ofType:(NSString*)type
{
    printf("Play '%s.%s': ",[name UTF8String],[type UTF8String]);
    dispatch_queue_t dispatchQueue = 
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *filePath = [mainBundle pathForResource:name
                                                  ofType:type];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        /* Start the audio player */
        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData
                                                         error:&error];
        [self applyAudioConfig];
        
        /* Did we get an instance of AVAudioPlayer? */
        if (self.audioPlayer != nil){
            /* Set the delegate and start playing */
            self.audioPlayer.delegate = self;
            if ([self.audioPlayer prepareToPlay] &&
                [self.audioPlayer play]){
                /* Successfully started playing */
                printf("Playing\n");
            } else {
                /* Failed to play */
                printf("Failed to play\n");
            }
        } else {
            /* Failed to instantiate AVAudioPlayer */
            printf("Failed to instantiate AVAudioPlayer");
        }
    });
}

- (void) applyAudioConfig
{
    [self.audioPlayer setVolume:audioPlayerVolume];
}

- (BOOL) setVolume:(float)vol
{
    printf("set volume: %.2f\n",vol);
    if (vol>=0 && vol<=1) {
        audioPlayerVolume = vol;
        if (self.audioPlayer!=nil) {
            [self.audioPlayer setVolume:vol];
        }
        return YES;
    }
    return NO;
}

@end
