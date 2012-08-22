//
//  WordMeanViewController.h
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "History.h"
@interface WordMeanViewController : UIViewController
{
    History *historyObj;

}

@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)rememberButtonTouch:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *IBRememberBtn;
@property (strong,nonatomic) History *historyObj;
@end
