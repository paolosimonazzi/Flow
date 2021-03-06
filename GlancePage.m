//
//  GlancePage.m
//  Flow
//
//  Created by Paolo Simonazzi on 3/8/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "GlancePage.h"
#import "GlanceCell.h"
#import "Connection.h"
#import "ContentPage.h"
#import "AmazingMenu.h"
#import "UserContent.h"

@interface GlancePage ()

@end

@implementation GlancePage

@synthesize friendsTable, menuRef, loadingPage, bottomLine;

#pragma mark - Connection
- (void) usersBack:(NSData*)_data {
	
	NSError* error;
	
	usersArray = [NSJSONSerialization JSONObjectWithData:_data //1
												 options:kNilOptions
												   error:&error];
	//[friends removeAllObjects];
	
	for (int idx = 0; idx<[usersArray count]; ++idx) {
	
		NSDictionary *profile = [[usersArray objectAtIndex:idx] objectForKey:@"profile"];
		
		NSLog(@"glance friends: %@ -> %@", [profile objectForKey:@"firstName"], [[usersArray objectAtIndex:idx] objectForKey:@"wavelinePreviewUrl"]);
	}
	//numFriends = [friends count];
	
	//NSLog(@"num users: %d", numFriends);
	[self.friendsTable reloadData];
	[loadingPage removeFromSuperview];
}

- (void) loadNetwork {
	
	Connection *conn = [[Connection alloc] initWithTarget:self withSelector:@selector(usersBack:)];
	[conn loadGlance];
	
}
- (void)viewWillAppear:(BOOL)animated {    // Called when the view is about to made visible. Default does nothing

	[self.view addSubview:loadingPage];
	[self loadNetwork];
	//[self.view addSubview:loadingPage];
}

- (void) friendshipDataBack:(NSData*)_data {

}
- (void) acceptFriendship:(int) _row {
	
	NSDictionary *user = [usersArray objectAtIndex:_row];
	
	NSNumber *ID = [user objectForKey:@"id"];
	
	Connection *friendAccepted = [[Connection alloc] initWithTarget:self withSelector:@selector(friendshipDataBack:)];
	[friendAccepted friendshipAccept:[ID longValue]];
	
	//[friendsTable reloadData];
	GlanceCell *myCell = [friendsTable cellForRowAtIndexPath:[NSIndexPath indexPathForItem:_row inSection:0]];
	[myCell loadingFriendShipVersion];
	//[self loadNetwork];
	
	
}
- (void) declineFriendship:(int) _row {

	NSDictionary *user = [usersArray objectAtIndex:_row];
	
	NSNumber *ID = [user objectForKey:@"id"];
	
	Connection *friendAccepted = [[Connection alloc] initWithTarget:self withSelector:@selector(friendshipDataBack:)];
	[friendAccepted friendshipDecline:[ID longValue]];

}

#pragma -

#pragma mark - Table's stuff

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int selectedRow = indexPath.row;
    NSLog(@"touch on row %d", selectedRow);
	NSDictionary *user = [usersArray objectAtIndex:indexPath.row];
	NSNumber *userId = [user objectForKey:@"id"];
	NSLog(@"friend's ID: %lu", [userId unsignedLongValue]);
	
	[menuRef.userContent setProfile:[usersArray objectAtIndex:indexPath.row]];
	[menuRef friendEventsVersion:[userId unsignedLongValue]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return  [usersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if ( nil == cell ) {
		cell = [[GlanceCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	GlanceCell *myCell = (GlanceCell*)cell;
	
	myCell.row = indexPath.row;
	myCell.GlancePageRef = self;
	
	NSDictionary *user = [usersArray objectAtIndex:indexPath.row];
	NSNumber *userId = [user objectForKey:@"id"];
	NSLog(@"friend's ID: %lu", [userId unsignedLongValue]);
	
	NSDictionary *userProfile = [user objectForKey:@"profile"];
	
	cell.backgroundView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
	cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];

	[myCell.profilePic loadImageAsync:[userProfile objectForKey:@"imageUrl"] withSpinner:YES];
	NSDate *today = [NSDate dateWithTimeIntervalSinceNow:0];
	NSDate *h24Earlier = [NSDate dateWithTimeIntervalSinceNow:-86400]; //-86400 //266400
	
	NSString *start_str = [NSString stringWithFormat:@"%d000", (int)[today timeIntervalSince1970]];
	
	NSString *stop_str = [NSString stringWithFormat:@"%d000", (int)[h24Earlier timeIntervalSince1970]];

	NSString *urlForGraph = [NSString stringWithFormat:@"http://glance-server.herokuapp.com/services/event/user-%lu/waveline-%@to%@?width=464&height=80",  [userId longValue], stop_str, start_str];
	NSLog(@"string for graph: %@", urlForGraph);
 	//[myCell.graphPic loadImageAsync:[user objectForKey:@"wavelinePreviewUrl"]];
	[myCell.graphPic loadImageAsync:urlForGraph withSpinner:NO];
	myCell.name.text = [userProfile objectForKey:@"firstName"];
	
	NSString *fStatus = [user objectForKey:@"friendshipStatus"];

	myCell.time.text = [user objectForKey:@"recentLocationName"];
	myCell.where.text = [user objectForKey:@"recentLocationTime"];
	
	if ([fStatus isEqualToString:@"REQUEST_RECEIVED"]) {
		[myCell acceptanceVersion];
	}
	return cell;
}

#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (BOOL)hasFourInchDisplay {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	if ([self hasFourInchDisplay]) {
		self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+44, self.view.frame.size.width, self.view.frame.size.height+88);
		self.bottomLine.frame = CGRectMake(bottomLine.frame.origin.x, bottomLine.frame.origin.y+88, bottomLine.frame.size.width, bottomLine.frame.size.height);
	} else {
	
	}
	
	self.friendsTable.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
	//friendsTable.delegate = self;
	
    // Do any additional setup after loading the view from its nib.
	loadingPage = [menuRef getLoadingPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
