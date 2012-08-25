//
//  RoomsListViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RoomsListViewController.h"

@implementation RoomsListViewController
@synthesize room;
@synthesize roomListArray;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    self.roomListArray =[[NSMutableArray alloc] initWithObjects:@"Room 1",@"Room 2",@"Room 3",@"Room 4",@"Room 5",@"Room 6",@"Room 7",@"Room 8",@"Room 9",@"Room 10", nil];
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
    int count= [self.roomListArray count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]]];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
    //Get the object from the array
    UIView *customView=[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 60.0f, 30.0f)];
    UILabel *cellLabel=[[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 60.0f, 30.0f)];
    cellLabel.backgroundColor = [UIColor clearColor];
    cellLabel.textColor = [UIColor blackColor];
    cellLabel.text = [NSString stringWithFormat:@"%d/255",234];
    cellLabel.textAlignment=UITextAlignmentLeft;
    cellLabel.font = [UIFont systemFontOfSize:15];
    [customView addSubview:cellLabel];
//       [cell setBackgroundColor:[UIColor clearColor]];
//         //Avartar
    cell.textLabel.text =[self.roomListArray objectAtIndex:indexPath.row];
//    
//    [cell addSubview:cellLabel];
    cell.accessoryView =customView;
    cell.accessoryType = UITableViewCellAccessoryNone;
    [tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    // Set up the cell
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)randomButtonTouch:(id)sender {
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
    NSString *imageName=[[NSString alloc]init];
    switch (indexPath.row %3) {
        case 0:
            imageName=@"RoomList1CellBackGround.png";
            break;
        case 1:
             imageName=@"RoomList2CellBackGround.png";
            break;
        case 2:
             imageName=@"RoomList3CellBackGround.png";
            break;
    }
    UIImage *imageBG=[UIImage imageNamed:imageName];
    UIImageView *imageBGView=[[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 60.0f)];
    imageBGView.image=imageBG;
    [cell setBackgroundView:imageBGView];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    return 60;
    
    
}

@end
