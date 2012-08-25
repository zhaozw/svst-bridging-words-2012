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
@synthesize bridgeView;
@synthesize currentContainer;
@synthesize timeProgressView;
@synthesize _startBridge;
@synthesize counter;
@synthesize _countdown;
@synthesize score;
@synthesize scoreLevel;
@synthesize currentCharacter;
@synthesize story;
@synthesize usedWords;
@synthesize soundHelper;

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
    self.wordTextField.placeholder = @"Input here";
    self._countdown = true;
    self.counter = 90;
    self.navigationItem.hidesBackButton = YES;
    [self countdown];
    self.scrollView.contentSize = CGSizeMake(320, 680);
    self.soundHelper = [[SoundHelper alloc] init];
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
    //self.resultLabel.text = @"";
    self.score = 0;
    self.scoreLevel = 10;
    self.currentCharacter = '*';
    self.usedWords  = [[NSMutableArray alloc] init];
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
            //NSLog(@"Update result: %@",self.wordTextField.text);
            if (self._startBridge == true) {
                self.scoreLevel = 10;
                self.score += self.scoreLevel;
                
                //TODO
                // update
                // draw new container
                //printf("draw new container");
                [self drawNewContainer:word];
                // draw label
                //self.resultLabel.text = [self.resultLabel.text stringByAppendingFormat:@"\n-%@",self.wordTextField.text];
                self._startBridge = false;
                printf("Set startBridge false\n");
                
            } else {
                self.scoreLevel *= 2;
                self.score += self.scoreLevel;
                
                //TODO
                //printf("draw new container");
                [self drawNewContainer:word];
                
                //self.resultLabel.text = [self.resultLabel.text stringByAppendingFormat:@" => %@",self.wordTextField.text];
            }
            
            //[self updateScore];
            self.wordTextField.text = @"";
            // update new text field position
        }
        
    }
    
}

- (void)drawNewContainer:(NSString *)word
{
    UIImage *containterImage = [UIImage imageNamed:@"train.PNG"];
    
    UIView *newContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
    //CGFloat dx = 100;
    newContainer.center = CGPointMake(self.currentContainer.center.x + self.currentContainer.bounds.size.width - 10, self.currentContainer.center.y);
    
    CGRect wordBound = newContainer.bounds;
    wordBound.size.height -= 12;
    //    UILabel *wordLabel = [[UILabel alloc] initWithFrame:wordBound];
    //    wordLabel.text = word;
    //    wordLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    //    wordLabel.textAlignment = UITextAlignmentCenter;
    //    [self.currentContainer addSubview:wordLabel];
    char lastCharacter = [word characterAtIndex:[word length]-1];
    char firstCharacter = [word characterAtIndex:0];
    
    UIWebView *wordWebView = [[UIWebView alloc] initWithFrame:wordBound];
    word = [word substringToIndex:[word length]-1];
    NSString *wordHtml;
    if (self._startBridge == false) {
        if ([word length]>=1) {
            word = [word substringFromIndex:1];
            wordHtml = [NSString stringWithFormat:@"<center><font color=\"green\">%c</font>%@<font color=\"red\">%c</font><center>",firstCharacter,word,lastCharacter];
        } else {
            wordHtml = [NSString stringWithFormat:@"<center>%@<font color=\"red\">%c</font><center>",word,lastCharacter];
        }
    } else {
        wordHtml = [NSString stringWithFormat:@"<center>%@<font color=\"red\">%c</font><center>",word,lastCharacter];
    }
    
    [wordWebView loadHTMLString:wordHtml baseURL:nil];
    [wordWebView setOpaque:NO];
    wordWebView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [self.currentContainer addSubview:wordWebView];
    
    self.currentContainer = newContainer;
    //NSLog(@"current container: %f, %f",self.currentContainer.bounds.size.height,self.currentContainer.bounds.size.width);
    UIImageView *containerImageView = [[UIImageView alloc] initWithFrame:newContainer.bounds];
    //UITextField *containerTextField = [[UITextField alloc] initWithFrame:newContainer.bounds];
    [containerImageView setImage:containterImage];
    [self.currentContainer addSubview:containerImageView];
    //[newContainer addSubview:containerTextField];
    [self.bridgeView addSubview:self.currentContainer];
    CGSize contentSize = self.scrollView.contentSize;
    contentSize.width = self.currentContainer.center.x + self.currentContainer.bounds.size.width;
    self.scrollView.contentSize = contentSize;
    printf("Add new container %f, %f\n",self.currentContainer.center.x,self.currentContainer.center.y);
    
    // update text field
    CGPoint textFieldCenter = newContainer.center;
    textFieldCenter.y -= 5 + 80;
    self.wordTextField.center = textFieldCenter;
    //self.wordTextField.placeholder = @"abc";
    //printf("x= %f, y= %f",self.wordTextField.bounds.origin.x,self.wordTextField.bounds.origin.y;
    
    [self.scrollView setContentOffset:CGPointMake( self.scrollView.contentSize.width - 320, self.scrollView.contentOffset.y) animated:YES];
    [self.soundHelper playSound:@"Jump" ofType:@"mp3"];
}	

- (void)drawNewTrain
{
    printf("Draw new train\n");
    printf("Current container: center(%.0f,%.0f)\n",self.currentContainer.center.x,self.currentContainer.center.y);
    // Update current container label ("END")
    // Draw train head
    CGFloat trainHeadY = self.currentContainer.center.y + 42;
    UIImage *trainHeadImage = [UIImage imageNamed:@"headtrainView.png"];
    UIImageView *trainHead = [[UIImageView alloc] initWithFrame:CGRectMake(29, trainHeadY, 86, 72)];
    [trainHead setImage:trainHeadImage];
    [self.bridgeView addSubview:trainHead];
    
    // Draw containter
    UIImage *containterImage = [UIImage imageNamed:@"train.PNG"];
    
    UIView *newContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
    //CGFloat dx = 100;
    
    newContainer.center = CGPointMake(100 + self.currentContainer.bounds.size.width/2, self.currentContainer.center.y + 89);
    
    CGRect wordBound = newContainer.bounds;
    wordBound.size.height -= 12;
    UILabel *wordLabel = [[UILabel alloc] initWithFrame:wordBound];
    wordLabel.text = @"END";
    wordLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    wordLabel.textAlignment = UITextAlignmentCenter;
    [self.currentContainer addSubview:wordLabel];
    
    self.currentContainer = newContainer;
    //NSLog(@"current container: %f, %f",self.currentContainer.bounds.size.height,self.currentContainer.bounds.size.width);
    UIImageView *containerImageView = [[UIImageView alloc] initWithFrame:newContainer.bounds];
    //UITextField *containerTextField = [[UITextField alloc] initWithFrame:newContainer.bounds];
    [containerImageView setImage:containterImage];
    [self.currentContainer addSubview:containerImageView];
    //[newContainer addSubview:containerTextField];
    [self.bridgeView addSubview:self.currentContainer];
    CGSize contentSize = self.scrollView.contentSize;
    if (self.currentContainer.center.y + self.currentContainer.bounds.size.height + 200> contentSize.height) {
        contentSize.height = self.currentContainer.center.y + self.currentContainer.bounds.size.height + 200;
        self.scrollView.contentSize = contentSize;
    }
    
    // update text field
    CGPoint textFieldCenter = newContainer.center;
    textFieldCenter.y -= 5 + 80;
    self.wordTextField.center = textFieldCenter;
    
    // update scroll content offset:
    [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentOffset.y) animated:YES];
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
        if ([self checkUsedWords:word]) {
            result = false;
            printf("%s is used\n", [word UTF8String]);
        } else {
            //printf("Added '%s' to usedWords",[word UTF8String]);
            [self.usedWords addObject:word];
            self.currentCharacter = [word characterAtIndex:[word length]-1];
        }
    }
    return result;
}

- (BOOL)checkUsedWords:(NSString*)word
{
    printf("Check used words:\n");
    if ([self.usedWords count]!=0) {
        for (int i=0; i<[self.usedWords count]; i++) {
            if ([[self.usedWords objectAtIndex:i] isEqual:word]) {
                return true;
            }
            //printf("%s is different from %s\n",[word UTF8String],[[usedWords objectAtIndex:i] UTF8String]);
        }
    }
    return false;
}

- (IBAction)finishButtonTouchUp:(id)sender {
    [self showResult];
}


- (IBAction)newBridge:(id)sender {
    self._startBridge = true;
}

- (void)countdown
{
    //self.counterLabel.text = [NSString stringWithFormat:@"%d",counter];
    if (self.counter != 0) {
        self.counter --;
        self.timeProgressView.progress = (float)self.counter/90;
        //        printf("counter/90: %.2f\n",((float)self.counter/90));
        //        printf("progress: %.2f\n",self.timeProgressView.progress);
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //CGPoint bottomOffset = CGPointMake(<#CGFloat x#>, <#CGFloat y#>)
    printf("current container center: %.0f\n",self.currentContainer.center.y - self.scrollView.contentOffset.y);
    printf("content offset: %.0f, %.0f\n",self.scrollView.contentOffset.x, self.scrollView.contentOffset.y);
    
    CGFloat currentContainerBottom = self.currentContainer.center.y - self.scrollView.contentOffset.y;
    if (400 - currentContainerBottom <200) {
        CGFloat currentOffsetY = self.scrollView.contentOffset.y;
        currentOffsetY -= 400 - currentContainerBottom - 200 - 50;
        [self.scrollView setContentOffset:CGPointMake(0, currentOffsetY) animated:YES];
    }
    
    //printf("offset need: %.0f", 480 - (self.currentContainer.center.y + 30 - self.scrollView.contentOffset.y));
    
    //    CGFloat currentContainerBottom = self.currentContainer.center.y + 30 - self.scrollView.contentOffset.y;
    //    if (480 - currentContainerBottom < 400) {
    //        CGFloat offsetY = 400 - 480 + currentContainerBottom;
    //        [self.scrollView setContentOffset:CGPointMake(0, offsetY) animated:YES];
    //        printf("botton: %.0f\n",currentContainerBottom);
    //    }
    
    return YES;
}

- (void)viewDidUnload
{
    [self setWordTextField:nil];
    [self setAddButton:nil];
    [self setResultLabel:nil];
    //[self setPointLabel:nil];
    [self setCounterLabel:nil];
    [self setScrollView:nil];
    [self setBridgeView:nil];
    [self setCurrentContainer:nil];
    [self setTimeProgressView:nil];
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
    if (self._startBridge == false) {
        self._startBridge = true;
        printf("Set startBridge true\n");
        self.currentCharacter = '*';
        [self drawNewTrain];
    }
}
- (IBAction)finishButtonTouch:(id)sender {
    [self.wordTextField resignFirstResponder];
    [self showResult];
    self._countdown = false;
}
@end
