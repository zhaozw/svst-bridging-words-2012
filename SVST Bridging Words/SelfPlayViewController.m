//
//  SelfPlayViewController.m
//  Bridging Words
//
//  Created by Mahmood1 on 8/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelfPlayViewController.h"
#import "ResultViewController.h"

@interface SelfPlayViewController ()

@end

@implementation SelfPlayViewController
@synthesize wordTextField;
@synthesize addButton;
@synthesize resultLabel;
@synthesize pointLabel;
@synthesize counterLabel;
@synthesize scrollView;
@synthesize _startBridge;
@synthesize counter;
@synthesize _countdown;
@synthesize score;
@synthesize scoreLevel;
@synthesize currentCharacter;
@synthesize story;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.wordTextField.delegate = self;
    self._countdown = true;
    self.counter = 10;
    self.navigationItem.hidesBackButton = YES;
    [self countdown];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.wordTextField resignFirstResponder];
    [self addWord];
    textField.text=nil;
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%@",self.story);
    self._startBridge = true;
    self._countdown = true;
    self.counter = 90;
    self.resultLabel.text = @"";
    self.score = 0;
    self.scoreLevel = 10;
    self.currentCharacter = '*';
    //[self updateScore];
}

- (void)addWord
{
    /*
     * TODO: check word and update result + point
     */
    NSString *word = self.wordTextField.text;
    if (![word isEqualToString:@""]) {
        if ([self checkWord:word]) {
            NSLog(@"Update result: %@",self.wordTextField.text);
            if (self._startBridge == true) {
                self.scoreLevel = 10;
                self.score += self.scoreLevel;
                
                //TODO
                // update
                // draw new container
                printf("draw new container");
                [self drawNewContainer];
                // draw label
                self.resultLabel.text = [self.resultLabel.text stringByAppendingFormat:@"\n-%@",self.wordTextField.text];
                self._startBridge = false;
                self.wordTextField.placeholder = @"Input hear";
                
                
            } else {
                self.scoreLevel *= 2;
                self.score += self.scoreLevel;
                
                //TODO
                printf("draw new container");
                [self drawNewContainer];
                
                self.resultLabel.text = [self.resultLabel.text stringByAppendingFormat:@" => %@",self.wordTextField.text];
            }
            
            //[self updateScore];
            self.wordTextField.text = @"";
            // update new text field position
        }
        
    }
    
}

- (void)drawNewContainer
{
    UIImage *containterImage = [UIImage imageNamed:@"train.PNG"];
    
    UIView *newContainer = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
    UIImageView *containerImageView = [[UIImageView alloc] initWithFrame:newContainer.bounds];
    //UITextField *containerTextField = [[UITextField alloc] initWithFrame:newContainer.bounds];
    [containerImageView setImage:containterImage];
    [newContainer addSubview:containerImageView];
    //[newContainer addSubview:containerTextField];
    [self.scrollView addSubview:newContainer];
    
    // update text field
    self.wordTextField.center = newContainer.center;
    self.wordTextField.placeholder = @"abc";
    //printf("x= %f, y= %f",self.wordTextField.bounds.origin.x,self.wordTextField.bounds.origin.y);
}

- (BOOL)checkWord:(NSString *)word
{
    /*
     * Check valid word
     */
    BOOL result = true;
    
    //Check valid word character
    NSInteger i;
    for (i=0; i<[word length]; i++) {
        if ([word characterAtIndex:i]>'z'||[word characterAtIndex:i]<'a') {
            result = false;break;
        }
    }
    
    //Check word in paragraph
    NSRange searchRange = NSMakeRange(0, [self.story length]);
    NSRange wordRange;
    //NSLog(@"STORY LENGTH: %d",[self.story length]);
    
    do {
        printf("Search %d letters, with range %d, %d\n",[self.story length],searchRange.location,searchRange.length);
        wordRange = [self.story rangeOfString:word options:NSCaseInsensitiveSearch range:searchRange];
        
        if (wordRange.location == NSNotFound){
            printf("%s is not found in story\n",[word cStringUsingEncoding:NSUTF8StringEncoding]);
            result = false;
        } else {
            NSInteger before = wordRange.location-1;
            NSInteger after = wordRange.location + wordRange.length;
            if (before>=0) {
                if ([self.story characterAtIndex:before]>'a'&&[self.story characterAtIndex:before]<'z') {
                    result = false;
                    printf("%s is not a word in story\n",[word cStringUsingEncoding:NSUTF8StringEncoding]);
                } else if(after<[self.story length])
                {
                    if ([self.story characterAtIndex:after]>'a'&&[self.story characterAtIndex:after]<'z') {
                        result = false;
                        printf("%s is not a word in story\n",[word cStringUsingEncoding:NSUTF8StringEncoding]);
                    } else {
                        result = true;
                    }
                }
            }
            
            searchRange.location = after;
            searchRange.length = [self.story length] - after;
            //NSLog(@"New searchRange: %d - %d",searchRange.location,searchRange.length);
        }
    } while (wordRange.location != NSNotFound && result==false);
    
    //Check valid bridge
    if (self.currentCharacter != '*') {
        if (self.currentCharacter != [word characterAtIndex:0]) {
            result = false;
            printf("%c != %c",self.currentCharacter,[word characterAtIndex:0]);
        }
    }
    
    if (result == true) {
        self.currentCharacter = [word characterAtIndex:[word length]-1];
    }
    return result;
}

- (IBAction)finishButtonTouchUp:(id)sender {
    [self showResult];
}


- (IBAction)newBridge:(id)sender {
    self._startBridge = true;
}

- (void)countdown
{
    self.counterLabel.text = [NSString stringWithFormat:@"%d",counter];
    if (self.counter != 0) {
        self.counter --;
    } else {
        if (self._countdown == true) {
            [self showResult];
            self._countdown = false;
        }
    }
    [self performSelector:@selector(countdown) withObject:nil afterDelay:1];
}

- (void)showResult
{
    /*
     * TODO: show result
     */
    ResultViewController *resultView;
    resultView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"resultView"];
    resultView.timeScore = self.counter;
    resultView.wordScore = self.score;
    self.counter = 0;
    [self.navigationController pushViewController:resultView animated:YES];
    
}

- (void)viewDidUnload
{
    [self setWordTextField:nil];
    [self setAddButton:nil];
    [self setResultLabel:nil];
    //[self setPointLabel:nil];
    [self setCounterLabel:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)updateScore
{
    self.pointLabel.text = [NSString stringWithFormat:@"%d",self.score];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)addButtonTouch:(id)sender {
    [self.wordTextField resignFirstResponder];
    [self addWord];
}

- (IBAction)newBridgeButtonTouch:(id)sender {
    self._startBridge = true;
    self.wordTextField.placeholder = @"Input new bridge";
    self.currentCharacter = '*';
}
- (IBAction)finishButtonTouch:(id)sender {
    [self.wordTextField resignFirstResponder];
    [self showResult];
    self._countdown = false;
}
@end
