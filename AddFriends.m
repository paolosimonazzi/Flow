//
//  AddFriends.m
//  Flow
//
//  Created by Paolo Simonazzi on 3/11/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "AddFriends.h"
#import "CellForAddingFriends.h"
#import "Connection.h"
#import "UIImage+animatedGIF.h"

@interface AddFriends ()

@end

@implementation AddFriends
@synthesize friendsToAddTable, usersArray, loadingPage, friends;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
		self.friendsToAddTable.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
    }
    return self;
}
- (void) usersBack:(NSData*)_data {
	
	NSError* error;
	
	usersArray = [NSJSONSerialization JSONObjectWithData:_data //1
													 options:kNilOptions
													   error:&error];
	[friends removeAllObjects];
	for (int idx = 0; idx<[usersArray count]; ++idx) {
		//NSDictionary *dict = [array objectAtIndex:idx] objectForKey:@"username";
		NSDictionary *user = [usersArray objectAtIndex:idx];
		
		NSNumber *isMyfriend = [user objectForKey:@"isMyFriend"];
		
		NSDictionary *profile = [user objectForKey:@"profile"];
		
		NSString *urlImage = [profile objectForKey:@"imageUrl"];

		NSLog(@"id: %@ - friend: %@", urlImage, [isMyfriend description]);
		[friends addObject:user];
		NSString *friendShipStatus = [user objectForKey:@"friendshipStatus"];
		
	}
	numFriends = [friends count];
	
	NSLog(@"num users: %d", numFriends);
	[self.friendsToAddTable reloadData];
	[loadingPage removeFromSuperview];

}
- (void)viewWillAppear:(BOOL)animated {    // Called when the view is about to made visible. Default does nothing
	[self loadNetwork];
	[self.view addSubview:loadingPage];
	[friendsToInvite removeAllObjects];
}

- (void) loadNetwork {
	
	Connection *conn = [[Connection alloc] initWithTarget:self withSelector:@selector(usersBack:)];
	[conn loadUsersNetwork];
	
}

- (void) viewDidLoad
{
    [super viewDidLoad];
	NSURL *url = [[NSBundle mainBundle] URLForResource:@"glance-animation" withExtension:@"gif"];
    
	self.gif.image = [UIImage animatedImageWithAnimatedGIFURL:url];
	loadingPage.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
    // Do any additional setup after loading the view from its nib.
	friends = [[NSMutableArray alloc] initWithCapacity:0];
	friendsToInvite = [[NSMutableArray alloc] initWithCapacity:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table's stuff

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int selectedRow = indexPath.row;
    NSLog(@"touch on row %d", selectedRow);
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
	for (int idx=0; idx<numFriends; ++idx) {
		NSLog(@"friends name: %@", [[[friends objectAtIndex:idx] objectForKey:@"profile"] objectForKey:@"firstName"]);
	}
	numCells = numFriends/3;//[friends count]/3;
    return ( numCells + (numFriends%3?1:0));
}

- (void) friendRequest: (int) num {

	[friendsToInvite addObject:[friends objectAtIndex:num]];
}
- (void) friendshipNoMore: (int) num {

	NSNumber *ID = [[friends objectAtIndex:num] objectForKey:@"id"];
	NSLog(@"I'm gonna delete this poor fiend: %@ ID:%lu", [[[friends objectAtIndex:num] objectForKey:@"profile"] objectForKey:@"firstName"], [ID longValue]);
	Connection *friendRequest = [[Connection alloc] initWithTarget:self withSelector:@selector(resultBack:)];
	[friendRequest friendshipNomore:[ID longValue]];

}
- (void) resultBack:(NSData*)_data {
	
	NSError* error;
	
	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:_data
													 options:kNilOptions
													   error:&error];
	
	NSLog(@"friends: %@ -> %@", [dict objectForKey:@"friendId"], [dict objectForKey:@"status"]);
}

- (IBAction) inviteFriendsClick:	(id) sender {
	for (int idx = 0; idx < [friendsToInvite count]; ++idx) {
		NSNumber *ID = [[friendsToInvite objectAtIndex:idx] objectForKey:@"id"];
		NSLog(@"I'm gonna invite these fiends: %@ ID:%lu", [[[friendsToInvite objectAtIndex:idx] objectForKey:@"profile"] objectForKey:@"firstName"], [ID longValue]);
		Connection *friendRequest = [[Connection alloc] initWithTarget:self withSelector:@selector(resultBack:)];
		[friendRequest friendshipRequest:[ID longValue]];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"CellForAddingFriends";

	int idx = indexPath.row*3;
	
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if ( nil == cell ) {
		cell = [[CellForAddingFriends alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	CellForAddingFriends *myCell = (CellForAddingFriends*) cell;
	myCell.addFriendsRef = self;
	cell.backgroundView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
	cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
	myCell.row = indexPath.row;
	
	if (numCells == indexPath.row) {
		int cellsToHide = numFriends%3;
		[myCell hideItems:cellsToHide];
	} else {

	}
	for (int idz=idx, idy=0; idz<idx+3; ++idz, ++idy) {
		if (idz>=numFriends) break;
		NSDictionary *user = [friends objectAtIndex:idz];
		NSDictionary *userProfile = [user objectForKey:@"profile"];
		if (idz<numFriends) {
			[myCell setTextForItem:idy text:[userProfile objectForKey:@"firstName"]];
			[myCell setImageUrlForItem:idy url:[userProfile objectForKey:@"imageUrl"]];

			NSString *fStatus = [user objectForKey:@"friendshipStatus"];

			if ([fStatus isEqualToString:@"ACCEPTED"]) {
				[myCell selectStatusCell:idy withStatus:FRIENDSALREADY];
				[myCell userSelected:idy changingStatus:NO];
			} else if ([fStatus isEqualToString:@"REQUEST_SENT"]) {
				[myCell selectStatusCell:idy withStatus:PENDING];
				[myCell userSelected:idy changingStatus:NO];
			}
		}
	}

	return cell;
}

#pragma mark -


@end
