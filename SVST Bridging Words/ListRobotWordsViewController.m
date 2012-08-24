//
//  simple dictionary project
//
//  Created by khoinguonit-mac on 11/1/11.
//  Copyright 2011 __KhoiNguonIT__. All rights reserved.
//

#import "ListRobotWordsViewController.h"
#import "AppDelegate.h"
#import "Robot.h"

@implementation ListRobotWordsViewController
@synthesize arrListDictObj, theTableView, arrListWord, searchResult;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton=YES;
	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5.0, 0.0, 320.0, 44.0)];
	searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 310.0, 44.0)];
	searchBarView.autoresizingMask = 0;
	searchBar.delegate = self;
	[searchBarView addSubview:searchBar];
	self.navigationItem.titleView = searchBarView;
	appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	self.title = @"Dictionary";
    
	self.arrListWord = [[NSMutableArray alloc] init];
	self.arrListDictObj = [[NSMutableArray alloc] init]; 
    self.arrListDictObj = [Robot getInitialDataToDisplay:[appDelegate getDBPath]];
	[self.arrListWord addObjectsFromArray:self.arrListDictObj];
}

#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrListDictObj count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setBackgroundView:nil];
    [tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]]];
    [tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
    UILabel *cellLabel=[[UILabel alloc]initWithFrame:CGRectMake(100.0f, 0.0f, 250.0f, 60.0f)];
    cellLabel.backgroundColor = [UIColor clearColor];
    cellLabel.textColor = [UIColor blackColor];
    cellLabel.text = [NSString stringWithFormat:@"%@",[self.arrListDictObj objectAtIndex:indexPath.row]];
    cellLabel.textAlignment=UITextAlignmentLeft;
    cellLabel.font = [UIFont systemFontOfSize:15];
    cellLabel.font =[UIFont fontWithName:@"ChalkboardSE-Bold" size:15];
    [cell addSubview:cellLabel];
    [cell setBackgroundColor:[UIColor clearColor]];
    [tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    return cell;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    Dict *dictObj = [[Dict alloc] init];
    //    // Navigation logic -- create and push a new view controller
    //	if(dvController == nil) dvController = [[DetailViewController alloc] initWithNibName:@"DetailView" bundle:nil];
    //	NSString *wordSelected;
    //	wordSelected = [self.arrListDictObj objectAtIndex:indexPath.row];
    //	//Get the detail view data if it does not exists.
    //	//We only load the data we initially want and keep on loading as we need.
    //	[dictObj hydrateDetailViewData:wordSelected];
    //	dvController.dictObj = dictObj;
    //	[self.navigationController pushViewController:dvController animated:YES];
}

#pragma mark searchBarTextDidBeginEditing
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	searchBar.showsCancelButton = NO;
}

- (void) reloadTable
{
	[self.arrListDictObj removeAllObjects];
	[self.arrListDictObj addObjectsFromArray:self.arrListWord];
	[theTableView reloadData];
	
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	
	//[self.arrListDictObj removeAllObjects];
	if([searchText length] == 0 || searchText == nil)
	{
		[self reloadTable];
		return;
	}
	else
	{
		NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", searchText];
		self.searchResult = [arrListWord filteredArrayUsingPredicate: predicate];
		self.arrListDictObj = [NSMutableArray arrayWithArray:self.searchResult];
		[theTableView reloadData];
	}
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    searchBar.text = @"";
	[self reloadTable];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
}



/*
 // Override to support conditional editing of the list
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support rearranging the list
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the list
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	[self.tableView reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
	[super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
	
	//Do not let the user add if the app is in edit mode.
	if(editing)
		self.navigationItem.leftBarButtonItem.enabled = NO;
	else
		self.navigationItem.leftBarButtonItem.enabled = YES;
}	

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 }
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
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


- (IBAction)menuButtonTouch:(id)sender {
    
    NSArray *currentControllers = self.navigationController.viewControllers;
    /* Create a mutable array out of this array */ 
    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
    /* Remove the last object from the array */ 
    [newControllers removeLastObject];
    [newControllers removeLastObject];
    [newControllers removeLastObject];
    /* Assign this array to the Navigation Controller */
    self.navigationController.viewControllers = newControllers;
    
}
@end

