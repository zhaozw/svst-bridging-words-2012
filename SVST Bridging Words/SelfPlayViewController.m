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
                self.resultLabel.text = [self.resultLabel.text stringByAppendingFormat:@"\n-%@",self.wordTextField.text];
                self._startBridge = false;
                self.wordTextField.placeholder = @"Input new word";
            } else {
                self.scoreLevel *= 2;
                self.score += self.scoreLevel;
                self.resultLabel.text = [self.resultLabel.text stringByAppendingFormat:@" => %@",self.wordTextField.text];
            }
            //[self updateScore];
            self.wordTextField.text = @"";
        }
        
    }
    
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
    NSRange searchRange = NSMakeRange(1, [self.story length]-1);
    NSRange wordRange;
    NSLog(@"STORY LENGTH: %d",[self.story length]);
    do {
        wordRange = [self.story rangeOfString:word options:NSCaseInsensitiveSearch range:searchRange];
        if (wordRange.location == NSNotFound){
            NSLog(@"%@ is not in story",word);
            result = false;
        } else {
            NSInteger before = wordRange.location-1;
            NSInteger after = wordRange.location + wordRange.length;
            if ([self.story characterAtIndex:before]>'a'&&[self.story characterAtIndex:before]<'z') {
                result = false;
                NSLog(@"%@ is not a word in story",word);
            } else if ([self.story characterAtIndex:after]>'a'&&[self.story characterAtIndex:after]<'z') {
                result = false;
                NSLog(@"%@ is not a word in story",word);
            } else {
                result = true;
            }
            
            searchRange.location = after;
            searchRange.length = [self.story length] - after;
            NSLog(@"New searchRange: %d - %d",searchRange.location,searchRange.length);
        }
    } while (wordRange.location != NSNotFound && result==false);
    
    //Check valid bridge
    if (self.currentCharacter != '*') {
        if (self.currentCharacter != [word characterAtIndex:0]) {
            result = false;
            NSLog(@"%c != %c",self.currentCharacter,[word characterAtIndex:0]);
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
    resultView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"resultView"];
    resultView.timeScore = self.counter*10;
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
