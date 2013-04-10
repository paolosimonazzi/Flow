//
//  CellForAddingFriends.m
//  Flow
//
//  Created by Paolo Simonazzi on 3/11/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "CellForAddingFriends.h"
#import "ContentPage.h"
#import "AddFriends.h"

@implementation CellForAddingFriends
@synthesize user0_sel, user2_sel, user1_sel,
			user0, user1, user2, user0Label, user1Label, user2Label,
			user0Button, user1Button, user2Button, row, addFriendsRef;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"CellForAddingFriends" owner:self options:nil];
		self = [nibArray objectAtIndex:0];
    }
    return self;
}

- (void) selectStatusCell:(int)_ncell withStatus:(int)_status {

	UIImageView *userSel;

	int		*userStatus = 0;

	switch (_ncell) {
		case 0:
			userStatus = &user0Status;
			userSel = user0_sel;
			break;
		case 1:
			userStatus = &user1Status;
			userSel = user1_sel;
			break;
		case 2:
			userStatus = &user2Status;
			userSel = user2_sel;
			break;
		default:
			break;
	}
	*userStatus = _status;
	if (FRIENDSALREADY == _status) {
		[userSel setImage:[UIImage imageNamed:@"add_friends_profile_mask_ring.png"]];
	} else if (PENDING == _status) {
		[userSel setImage:[UIImage imageNamed:@"add_friends_profile_mask_ring_red.png"]];
	}

}
- (void) userSelected:(int)num changingStatus:(BOOL)_sta {
	float animationTime = 0.5;
	UIImageView *userSel, *user;
	CGRect translation;
	int *userStatus = 0;
	BOOL *userSelected;
	switch (num) {
		case 0: {
			translation = CGRectMake(20, 10, 65, 65);;
			userStatus = &user0Status;
			userSel = user0_sel;
			user = user0;
			userSelected = &user0Selected;
		}
			break;
			
		case 1: {
			translation = CGRectMake(125, 10, 65, 65);
			userStatus = &user1Status;
			userSel = user1_sel;
			user = user1;
			userSelected = &user1Selected;
		}
			break;
		case 2: {
			translation = CGRectMake(230, 10, 65, 65);
			userStatus = &user2Status;
			userSel = user2_sel;
			user = user2;
			userSelected = &user2Selected;
		}
			break;
		default:
			break;
	}
	*userSelected = TRUE;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: animationTime];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDelegate:self];
	//[UIView setAnimationDidStopSelector:@selector(animationContentsFeedVersionFinished)];
	
	userSel.frame = translation;
	user.alpha = 1.0;
	[UIView commitAnimations];
	
	if (_sta)
		[self selectStatusCell:num withStatus:PENDING];

}
- (void) restorePositionItem0 {
	user0_sel.frame = CGRectMake(-100, 10, 65, 65);
}
- (void) restorePositionItem1 {
	user1_sel.frame = CGRectMake(-100, 10, 65, 65);
}
- (void) restorePositionItem2 {
	user2_sel.frame = CGRectMake(-100, 10, 65, 65);
}

- (void) userUnselected:(int)num {
	float animationTime = 0.5;
	UIImageView *userSel, *user;
	BOOL *userSelected;
	int *userStatus;
	
	switch (num) {
		case 0: {
			userSel = user0_sel;
			user = user0;
			userStatus = &user0Status;
			userSelected = &user0Selected;
		}
			break;
			
		case 1: {
			userSel = user1_sel;
			user = user1;
			userStatus = &user1Status;
			userSelected = &user1Selected;
		}
			break;
		case 2: {
			userSel = user2_sel;
			user = user2;
			userStatus = &user2Status;
			userSelected = &user2Selected;
		}
			break;
		default:
			break;
	}
	*userSelected = FALSE;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration: animationTime];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDelegate:self];
	if (0 == num)
		[UIView setAnimationDidStopSelector:@selector(restorePositionItem0)];
	else if (1 == num)
		[UIView setAnimationDidStopSelector:@selector(restorePositionItem1)];
	else if (2 == num)
		[UIView setAnimationDidStopSelector:@selector(restorePositionItem2)];
	*userStatus = NONE;
	userSel.frame = CGRectMake(340, 10, 65, 65);;
	user.alpha = .5;
	[UIView commitAnimations];
	
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
		[addFriendsRef friendshipNoMore:friendToRemove];
		[self userUnselected:friendToUnselect];
    }
}
-(void) userAction:(int) user {
	BOOL *userSelected;
	switch (user) {
		case 0:
			userSelected = &user0Selected;
			break;
		case 1:
			userSelected = &user1Selected;
			break;
		case 2:
			userSelected = &user2Selected;
			break;
		default:
			break;
	}
	
	if ( NO == *userSelected ) {
		[self userSelected:user changingStatus:YES];
		[addFriendsRef friendRequest:row*3+user];
	} else {
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Frank?" message:@"Do you really want to do this?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[message addButtonWithTitle:@"Yes"];
		[message show];
		friendToRemove = row*3+user;
		friendToUnselect = user;
 		/* 
		[addFriendsRef friendshipNoMore:row*3+user];
		[self userUnselected:user];
		 */
	}
}
-(IBAction) userClick:	(id) sender {
	UIButton *button = (UIButton*)sender;
	[self userAction:button.tag];
}

- (void) hideItems:(int) num {
	if (2 == num) {
		user2.hidden = TRUE; user2Label.hidden = TRUE;
		user2Button.hidden = TRUE;
	} else if (1 == num) {
		user1.hidden = TRUE; user1Label.hidden = TRUE;
		user2.hidden = TRUE; user2Label.hidden = TRUE;
		user1Button.hidden = TRUE;
		user2Button.hidden = TRUE;
	}
}
- (void) setTextForItem:(int)num text:(NSString*)str {
	switch (num) {
		case 0:
			user0Label.text = str;
			break;
		case 1:
			user1Label.text = str;
			break;
		case 2:
			user2Label.text = str;
			break;
			
		default:
			break;
	}
}
- (void) setImageUrlForItem:(int)num url:(NSString*)url_str {
	
	switch (num) {
		case 0:
			[user0 loadImageAsync:url_str withSpinner:YES];
			break;
		case 1:
			[user1 loadImageAsync:url_str withSpinner:YES];
			break;
		case 2:
			[user2 loadImageAsync:url_str withSpinner:YES];
			break;
			
		default:
			break;
	}
}

/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
*/
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
