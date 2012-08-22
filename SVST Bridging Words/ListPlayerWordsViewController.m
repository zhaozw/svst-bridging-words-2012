//
//  ListPlayerWordsViewController.m
//  SVST Bridging Words
//
//  Created by Mahmood1 on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListPlayerWordsViewController.h"
#import "History.h"
#import "AppDelegate.h"
#import "WordMeanViewController.h"

@implementation ListPlayerWordsViewController
@synthesize myArray;
@synthesize arrListWords;
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
    self.arrListWords=[[NSMutableArray alloc]init];
    [self.arrListWords addObjectsFromArray:self.myArray];    

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

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.arrListWords.count==0) {
        return NULL;
    }
          return [self.arrListWords count];
    

  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setBackgroundView:nil];
    [tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]]];
    [tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
    UILabel *cellLabel=[[UILabel alloc]initWithFrame:CGRectMake(100.0f, 0.0f, 250.0f, 60.0f)];
    cellLabel.backgroundColor = [UIColor clearColor];
    cellLabel.textColor = [UIColor blackColor];
    cellLabel.text = [NSString stringWithFormat:@"%@",[self.arrListWords objectAtIndex:indexPath.row]];
    cellLabel.textAlignment=UITextAlignmentLeft;
    cellLabel.font = [UIFont systemFontOfSize:15];
    cellLabel.font =[UIFont fontWithName:@"ChalkboardSE-Bold" size:15];
    [cell addSubview:cellLabel];
    [cell setBackgroundColor:[UIColor clearColor]];
        [tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
    UIImage *imageBG=[UIImage imageNamed:@"historyImage2.png"];
    UIImageView *imageBGView=[[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 150.0f, 60.0f)];
    imageBGView.image=imageBG;
    [cell setBackgroundView:imageBGView];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    return 60;
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
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
    // Navigation logic may go here. Create and push another view controller.
    // Start request
      WordMeanViewController *detailViewController;
    detailViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"wordMeanView"];
    History *historyObj=[[History alloc]init];
    [historyObj wordMeanForWord:[self.arrListWords objectAtIndex:indexPath.row]];
    
    detailViewController.historyObj =historyObj;
    detailViewController.historyObj.word=[self.arrListWords objectAtIndex:indexPath.row];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
//JSON connection


@end
