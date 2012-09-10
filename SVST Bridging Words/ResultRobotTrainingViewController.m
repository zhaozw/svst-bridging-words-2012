//
//  ResultRobotTrainingViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResultRobotTrainingViewController.h"
#import "TrainRobotViewController.h"

@interface ResultRobotTrainingViewController ()

@end

@implementation ResultRobotTrainingViewController
@synthesize imageViewBackGround;
@synthesize mainMenuButtonTouch;
@synthesize myLabel;
@synthesize resultLabel,errorMsg,arrListWrongWords;

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
    self.navigationItem.hidesBackButton=YES;
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setResultLabel:nil];
    [self setMainMenuButtonTouch:nil];
    [self setMyLabel:nil];
    [self setImageViewBackGround:nil];
    [super viewDidUnload];
    self.navigationItem.hidesBackButton=YES;
    
    // Release any retained subviews of the main view.
}
-(void) viewDidAppear:(BOOL)animated{
       //self.resultLabel.text=self.errorMsg;
   // self.resultLabel.textAlignment= UITextAlignmentCenter;
    
    [self.navigationController setNavigationBarHidden:NO];
    if ([self.arrListWrongWords count]==0) {
        NSLog(@"There is no wrong words");
    }
    else {
        NSLog(@"%@",[self.arrListWrongWords objectAtIndex:0]);
    }
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)replayButtonTouch:(id)sender {
    /* Get the current array of View Controllers */
    NSArray *currentControllers = self.navigationController.viewControllers;
    /* Create a mutable array out of this array */ 
    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
    /* Remove the last object from the array */ 
    [newControllers removeLastObject];
    /* Assign this array to the Navigation Controller */
    self.navigationController.viewControllers = newControllers;
}
- (IBAction)backToMainMenu:(id)sender {
    /* Get the current array of View Controllers */
    NSArray *currentControllers = self.navigationController.viewControllers;
    [self.navigationController popToViewController:[currentControllers objectAtIndex:1] animated:YES];
}
-(void) viewErrorMsg:(NSInteger) intMsg
{
    switch (intMsg) {
        case 1:
        {
            self.errorMsg=@" Robot has known this word";
            UIView *customView=[[UIView alloc]initWithFrame:CGRectMake(90.0f, 210.0f, 250.0f, 50.0f)];
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 230.0f, 50.0f)];
            UIImage *imageRobotBG=[UIImage imageNamed:@"RobotCommentBG.png"];
            imageView.image=imageRobotBG;
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 230.0f, 50.0f)];
            label.text=self.errorMsg;
            label.textColor=[UIColor whiteColor];
            label.font=[UIFont fontWithName:@"ChalkboardSE" size:12];
            label.backgroundColor=[UIColor clearColor];
            
            [customView addSubview:imageView];
            [customView addSubview:label];
            [self.view addSubview:customView];
            imageViewBackGround.image=[UIImage imageNamed:@"lose_scence2.png"];
            [imageView addSubview:myLabel];
            break;
        }
       
            
        case 2:
        {
            self.errorMsg=@"Robot has been defeated. Congratulation!";
            UIView *customView=[[UIView alloc]initWithFrame:CGRectMake(90.0f, 210.0f, 250.0f, 70.0f)];
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 230.0f, 70.0f)];
            UIImage *imageRobotBG=[UIImage imageNamed:@"RobotCommentBG.png"];
            imageView.image=imageRobotBG;
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 230.0f, 70.0f)];
            label.text=self.errorMsg;
            label.numberOfLines=3;
            label.textColor=[UIColor whiteColor];
            label.font=[UIFont fontWithName:@"ChalkboardSE" size:12];
            label.backgroundColor=[UIColor clearColor];
            
            [customView addSubview:imageView];
            [customView addSubview:label];
            [self.view addSubview:customView];
            imageViewBackGround.image=[UIImage imageNamed:@"win_scence2.png"];
            [imageView addSubview:myLabel];
             break;
        }

           
        case 3: 
        {
            self.errorMsg=@"You lose! \n You have enterd word twice.";
            UIView *customView=[[UIView alloc]initWithFrame:CGRectMake(90.0f, 210.0f, 250.0f, 50.0f)];
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 230.0f, 50.0f)];
            UIImage *imageRobotBG=[UIImage imageNamed:@"RobotCommentBG.png"];
            imageView.image=imageRobotBG;
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 230.0f, 50.0f)];
            label.text=self.errorMsg;
            label.textColor=[UIColor whiteColor];
            label.font=[UIFont fontWithName:@"ChalkboardSE" size:12];
            label.backgroundColor=[UIColor clearColor];
            label.numberOfLines=2;
            [customView addSubview:imageView];
            [customView addSubview:label];
            [self.view addSubview:customView];
            imageViewBackGround.image=[UIImage imageNamed:@"lose_scence2.png"];
            [imageView addSubview:myLabel];
             break;
        }
 
           
        case 4:
        {           self.errorMsg=@"You have been defeated by your robot.\n You entered a wrong word. \n Try again!";
            UIView *customView=[[UIView alloc]initWithFrame:CGRectMake(90.0f, 210.0f, 250.0f, 120.0f)];
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 230.0f, 120.0f)];
            UIImage *imageRobotBG=[UIImage imageNamed:@"RobotCommentBG.png"];
            imageView.image=imageRobotBG;
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 230.0f, 110.0f)];
            label.text=self.errorMsg;
            label.numberOfLines=4;
            label.textColor=[UIColor whiteColor];
            label.font=[UIFont fontWithName:@"ChalkboardSE" size:12];
            label.backgroundColor=[UIColor clearColor];
            
            [customView addSubview:imageView];
            [customView addSubview:label];
            [self.view addSubview:customView];
            imageViewBackGround.image=[UIImage imageNamed:@"lose_scence2.png"];
            [imageView addSubview:myLabel];
            
            break;

        }
             
            
            
        default: 
        
        {
            self.errorMsg=@" Game Finished.";
            UIView *customView=[[UIView alloc]initWithFrame:CGRectMake(90.0f, 210.0f, 250.0f, 50.0f)];
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 230.0f, 50.0f)];
            UIImage *imageRobotBG=[UIImage imageNamed:@"RobotCommentBG.png"];
            imageView.image=imageRobotBG;
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 230.0f, 50.0f)];
            label.text=self.errorMsg;
            label.textColor=[UIColor whiteColor];
            label.font=[UIFont fontWithName:@"ChalkboardSE" size:12];
            label.backgroundColor=[UIColor clearColor];
            
            [customView addSubview:imageView];
            [customView addSubview:label];
            [self.view addSubview:customView];
            imageViewBackGround.image=[UIImage imageNamed:@"lose_scence2.png"];
            [imageView addSubview:myLabel];
            break;

        }
    }    
    
}
@end
