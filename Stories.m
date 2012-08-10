//
//  Stories.m
//  SQLTEST
//
//  Created by Mahmood1 on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Stories.h"

@implementation Stories
@synthesize content;
-(id) initWithContent:(NSString *)c

{
    self.content=c;
    return  self;
}

@end
