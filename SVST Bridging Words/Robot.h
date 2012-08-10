//
//  Robot.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Robot : NSObject
{

    NSUInteger wordCount;
    NSString *word;
    NSString *wordMean;
    NSUInteger wordId;
    
}
@property (strong,nonatomic) NSString *word;
@property (strong,nonatomic) NSString *wordMean;

@end
