//
//  StoriesViewController.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoriesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property NSInteger counter;

@end
