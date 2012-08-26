//
//  DeskListViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DeskListViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import "MBProgressHUD.h"
#import "PlayerProfileViewController.h"
#import "DeskViewController.h"

static int countRow;
@implementation DeskListViewController
@synthesize desk,deskListArr,room;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewDidAppear:(BOOL)animated{

    self.deskListArr=[[NSMutableArray alloc]init ];
    NSURL *url = [NSURL URLWithString:@"http://bobbymistery.byethost11.com/bw/multiplayer/room.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[NSString stringWithFormat:@"%d", self.room.roomID] forKey:@"ROOM_ID"];
    NSLog(@"%d",self.room.roomID);
    [request setPostValue:@"1" forKey:@"PLAYER_ID"];
    [request setDelegate:self];
    [request startAsynchronous];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
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
            Desk *deskObj=[[Desk alloc]init];
            deskObj.player1ID=[[tweet valueForKey:@"PLAYER1_ID"]integerValue];
            deskObj.player2ID=[[tweet valueForKey:@"PLAYER2_ID"]integerValue];
            deskObj.player1Name=[tweet valueForKey:@"PLAYER1_NAME"];
            deskObj.player2Name=[tweet valueForKey:@"PLAYER2_NAME"];
            [deskListArr addObject:deskObj];
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    int countRow =[self.deskListArr count];
    if (countRow==0) {
        return 0;
    }
    return countRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageName=[[NSString alloc]init];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
    //Get the object from the array.PLayer 1
    UILabel *player1Name=[[UILabel alloc]initWithFrame:CGRectMake(100.0f, -5.0f, 250.0f, 60.0f)];
    player1Name.backgroundColor = [UIColor clearColor];
    player1Name.textColor = [UIColor greenColor];
    desk=[self.deskListArr objectAtIndex:indexPath.row];
    player1Name.text = [NSString stringWithFormat:@"%@",desk.player1Name];
    player1Name.textAlignment=UITextAlignmentLeft;
    player1Name.font = [UIFont systemFontOfSize:15];
    player1Name.font =[UIFont fontWithName:@"ChalkboardSE-Bold" size:15];
    
    //Player2 
    UILabel *player2Name=[[UILabel alloc]initWithFrame:CGRectMake(110.0f, 15.0f, 250.0f, 60.0f)];
    player2Name.backgroundColor = [UIColor clearColor];
    player2Name.textColor = [UIColor grayColor];
    player2Name.text = [NSString stringWithFormat:@"vs %@",desk.player2Name];
    player2Name.textAlignment=UITextAlignmentLeft;
    player2Name.font = [UIFont systemFontOfSize:15];
    player2Name.font =[UIFont fontWithName:@"ChalkboardSE-Bold" size:15];
    [cell addSubview:player1Name];
    [cell addSubview:player2Name];
    [cell setBackgroundColor:[UIColor clearColor]];

    //Flag
    if (desk.player2ID==0) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    Desk *deskObj=[[Desk alloc]init];
    deskObj=[deskListArr objectAtIndex:indexPath.row];
    if (desk.player2ID>0) {
        return;
    }
else {
    DeskViewController *deskView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"deskView"];
    deskView.player1.playerName=deskObj.player1Name;
    deskView.player1.playerID=[NSString stringWithFormat:@"%@", deskObj.player1ID];
    deskView.player2.playerName=@"You";
    deskView.player2.playerID=@"1";
    NSURL *url = [NSURL URLWithString:@"http://bobbymistery.byethost11.com/bw/multiplayer/room.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"1" forKey:@"JOIN_MY_ID"];
    [request setPostValue:[NSString stringWithFormat:@"%@", deskObj.player1ID] forKey:@"JOIN_HOST_ID"];
    [request setDelegate:self];
    [request startAsynchronous];

    [self.navigationController pushViewController:deskView animated:YES];

}

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
    detailLabel.text = @"List Desks";
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
- (IBAction)randomButtonTouch:(id)sender {
   
}

- (IBAction)newDeskButtonClick:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://bobbymistery.byethost11.com/bw/multiplayer/room.php"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"1" forKey:@"ADD_MY_ID"];
    [request setDelegate:self];
    [request startAsynchronous];
    DeskViewController *deskView = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"deskView"];
    Desk *deskObj=[[Desk alloc]init];
    deskObj.player1ID=1;
    deskObj.player2ID=0;
    deskObj.player1Name=@"You";
    deskObj.player2Name=@"";
    deskView.desk=deskObj;
    [self.navigationController pushViewController:deskView animated:YES];


}
@end
