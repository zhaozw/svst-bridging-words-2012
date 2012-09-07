//
//  FriendsListViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendsListViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "MBProgressHUD.h"
#import "PlayerProfileViewController.h"
@interface FriendsListViewController ()

@end

@implementation FriendsListViewController
@synthesize listFriendObj;
@synthesize isReady;
@synthesize friendObj;
@synthesize myRequest;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewDidAppear:(BOOL)animated
{
    isReady=false;
    self.listFriendObj=[[NSMutableArray alloc]init ];
    NSURL *url = [NSURL URLWithString:@"http://bobbymistery.byethost11.com/bw/multiplayer/"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"1" forKey:@"PLAYER_ID"];
    [request setPostValue:@"1" forKey:@"STT"];
    self.myRequest=request;
    [request setDelegate:self];
    [request startAsynchronous];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";


}
- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"viewWillDisappear");
    [self.myRequest setDelegate:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
     
}
- (void)requestFinished:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (request.responseStatusCode == 400) {
        NSLog( @"Invalid code");        
    }
    else if (request.responseStatusCode == 403) {
        NSLog(@"Code already used");
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        NSLog(@"string%@",responseString);
        NSDictionary *responseDict = [responseString JSONValue] ;
        NSArray *tweets=[[responseDict objectForKey:@"posts"] valueForKey:@"post"];
        for (NSDictionary *tweet in tweets)
        {
            Player *playerObj=[[Player alloc]init];
            playerObj.playerID  = [tweet valueForKey:@"FRIEND_ID"];
            playerObj.playerName= [tweet valueForKey:@"NAME"];
            playerObj.status= [tweet valueForKey:@"STATUS"];
            playerObj.stt= [[tweet valueForKey:@"STT"] integerValue];
            playerObj.numberWordsUse=[[tweet valueForKey:@"NUMBER_WORDS_USED"] integerValue];
            playerObj.inRoomNumber=[[tweet valueForKey:@"ROOM"]integerValue];
            playerObj.playerScore=[[tweet valueForKey:@"SCORE"]integerValue];
            playerObj.numberWin=[[tweet valueForKey:@"WIN"]integerValue];
            playerObj.numberLose=[[tweet valueForKey:@"LOSE"]integerValue];
            [listFriendObj addObject:playerObj];
        }
        
    } else {
        NSLog(@"Unexpected error");
    }
    [self.tableView reloadData];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSError *error = [request error];
    NSLog(@"%@",error.localizedDescription);
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    NSLog(@"View unload");
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    int count=[listFriendObj count];
    if (count==0) {
        return 0;
    }
    return [listFriendObj count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *imageName=[[NSString alloc]init];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
    //Get the object from the array.
    UILabel *cellLabel=[[UILabel alloc]initWithFrame:CGRectMake(100.0f, 0.0f, 250.0f, 60.0f)];
    cellLabel.backgroundColor = [UIColor clearColor];
    cellLabel.textColor = [UIColor blackColor];
    friendObj=[listFriendObj objectAtIndex:indexPath.row];
    cellLabel.text = [NSString stringWithFormat:@"%@",friendObj.playerName];
    cellLabel.textAlignment=UITextAlignmentLeft;
    cellLabel.font = [UIFont systemFontOfSize:15];
    cellLabel.font =[UIFont fontWithName:@"ChalkboardSE-Bold" size:15];
    
    //Room Label
    UILabel *roomLabel=[[UILabel alloc]initWithFrame:CGRectMake(210.0f, 0.0f, 250.0f, 60.0f)];
    roomLabel.backgroundColor = [UIColor clearColor];
    roomLabel.textColor = [UIColor redColor];
    if (friendObj.inRoomNumber==0) {
         roomLabel.text =@"";
    }
    else {
        roomLabel.text = [NSString stringWithFormat:@"Room %d",friendObj.inRoomNumber];
    }
    
    roomLabel.textAlignment=UITextAlignmentLeft;
    roomLabel.font = [UIFont systemFontOfSize:15];
    roomLabel.font =[UIFont fontWithName:@"ChalkboardSE-Bold" size:15];
    //Label Status
    UILabel *statusLabel=[[UILabel alloc]initWithFrame:CGRectMake(100.0f, 28.0f, 250.0f, 33.0f)];
    statusLabel.backgroundColor = [UIColor clearColor];
    statusLabel.textColor = [UIColor blueColor];
    NSString *friendStt=[[NSString alloc]init];
    if (friendObj.status== NULL) {
        friendStt=@"hello";
    }else {
        friendStt=friendObj.status;
    }
    
    statusLabel.text = [NSString stringWithFormat:@"%@",friendStt];
    statusLabel.textAlignment=UITextAlignmentLeft;
    statusLabel.font = [UIFont systemFontOfSize:10];
    statusLabel.font =[UIFont fontWithName:@"ChalkboardSE-Bold" size:10];
    
    
    ///
    [cell addSubview:roomLabel];
    [cell addSubview:statusLabel];
    [cell addSubview:cellLabel];
    [cell setBackgroundColor:[UIColor clearColor]];
    // Flag Image 
    if (friendObj.stt==1) {
        imageName=@"flag_ready.png";
    }
    else {
        imageName=@"flag_unready.png";
    }
    UIImage *imageFlag=[UIImage imageNamed:imageName];
    UIImageView *imageView=[[UIImageView alloc] initWithImage:imageFlag];
    imageView.frame=CGRectMake(0.0f, 0.0f, 35.0f, 35.0f);
    //Avartar
    
    cell.accessoryView= imageView;
    cell.accessoryType = UITableViewCellAccessoryNone;
    [tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    // Set up the cell
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    [tableView setBackgroundView:nil];
    [tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]]];
    [tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,20.0f)];
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,20.0f)];
    UIImage *image=[UIImage imageNamed:@"tiltleHeaderBackGround.png"];
    imageView.image=image;
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.textColor = [UIColor whiteColor];
    detailLabel.text = @"List Friends";
    detailLabel.textAlignment=UITextAlignmentCenter;
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.font =[UIFont fontWithName:@"ChalkboardSE-Bold" size:15];
    detailLabel.frame = CGRectMake(0.0f,5.0f,320.0f,15.0f);
    
    [customView addSubview:imageView];
    [customView addSubview:detailLabel];
    return customView;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
    UIImage *imageBG=[UIImage imageNamed:@"cellBackGround.png"];
    UIImageView *imageBGView=[[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 60.0f)];
    imageBGView.image=imageBG;
    [cell setBackgroundView:imageBGView];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    return 60;
    
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    PlayerProfileViewController *profileView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"playerProfileView"];
    profileView.playerProfile=[listFriendObj objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:profileView animated:YES];
    
}


@end
