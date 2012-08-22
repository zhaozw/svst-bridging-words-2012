//
//  HistoryPlayersViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HistoryPlayersViewController.h"
#import "History.h"
#import "AppDelegate.h"
#import "ListPlayerWordsViewController.h"
#import "ClearHistoryViewController.h"

@implementation HistoryPlayersViewController
@synthesize arrListPlayers,arrListPlayerObj;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
//    CGRect frame = CGRectMake(0, 0, 200.0, 768.0); //you can adjust the width or height or position of the tableView
//    self.tableView = [[UITableView alloc] initWithFrame:frame];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;  

}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Messages";
    self.arrListPlayerObj= [[NSMutableArray alloc]init];   
    self.arrListPlayers = [[NSMutableArray alloc] init];
    //AppDelegate *appDelegate =[[AppDelegate alloc]init];  
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   
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

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int count=[appDelegate.playerArr count];
  return [appDelegate.playerArr count];
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
    detailLabel.text = @"List Players";
    detailLabel.textAlignment=UITextAlignmentCenter;
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.font =[UIFont fontWithName:@"ChalkboardSE-Bold" size:15];
    detailLabel.frame = CGRectMake(0.0f,5.0f,320.0f,15.0f);
  
    [customView addSubview:imageView];
      [customView addSubview:detailLabel];
    return customView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
    //Get the object from the array.
    History *playersObj = [appDelegate.playerArr objectAtIndex:indexPath.row];
    UILabel *cellLabel=[[UILabel alloc]initWithFrame:CGRectMake(100.0f, 0.0f, 250.0f, 60.0f)];
    cellLabel.backgroundColor = [UIColor clearColor];
    cellLabel.textColor = [UIColor blackColor];
    cellLabel.text = [NSString stringWithFormat:@"%@",playersObj.playerName];
    cellLabel.textAlignment=UITextAlignmentLeft;
    cellLabel.font = [UIFont systemFontOfSize:15];
    cellLabel.font =[UIFont fontWithName:@"ChalkboardSE-Bold" size:15];
    [cell addSubview:cellLabel];
    [cell setBackgroundColor:[UIColor clearColor]];
    
   cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    // Set up the cell
    return cell;
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView can	EditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    History *playersObj = [appDelegate.playerArr objectAtIndex:indexPath.row];
    NSLog(@"%d",playersObj.playerID);   
    ListPlayerWordsViewController *dvListHistoryViewCL=[[ListPlayerWordsViewController alloc] init];
    if ([[playersObj detailDataToDisplay:playersObj.playerID] count]!=0) {
        dvListHistoryViewCL.myArray=[playersObj detailDataToDisplay:playersObj.playerID];
        [self.navigationController pushViewController:dvListHistoryViewCL animated:YES];
    
    }
    else {
        ClearHistoryViewController *dvClearHistory = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"clearHistory"];
            dvClearHistory.playerName=playersObj.playerName;
         [self.navigationController pushViewController:dvClearHistory animated:YES];
    }
}

@end
