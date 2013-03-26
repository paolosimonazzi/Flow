//
//  AddFriends.h
//  Flow
//
//  Created by Paolo Simonazzi on 3/11/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriends :  UIViewController <UITableViewDataSource, UITableViewDelegate> {

	int numCells;
	int numFriends;
	NSMutableArray *friendsToInvite;
}


@property (nonatomic, retain) IBOutlet	UITableView *friendsToAddTable;

@property (nonatomic, retain)			NSArray		*usersArray;

@property (nonatomic, retain) IBOutlet	UIView		*loadingPage;
@property (nonatomic, retain) IBOutlet	UIImageView *gif;

@property (nonatomic, retain)			NSMutableArray *friends;

- (IBAction) inviteFriendsClick:	(id) sender;

- (void)	 friendRequest:		(int) num;
- (void)     friendshipNoMore:	(int) num;
@end
