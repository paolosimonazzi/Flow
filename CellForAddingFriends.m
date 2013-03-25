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
- (void) selectUser:(int)num withStatus:(int)_status {
	UIImageView *userSel;
	int			*userStatus=0;
	
	switch (num) {
		case 0:
			userSel = user0_sel;
			userStatus = &user0Status;
			break;
		case 1:
			userSel = user1_sel;
			userStatus = &user1Status;
			break;
		case 2:
			userSel = user2_sel;
			userStatus = &user2Status;
			break;
		default:
			break;
	}
	if (FRIENDSALREADY == _status) {
		[userSel setImage:[UIImage imageNamed:@"add_friends_profile_mask_ring.png"]];
	} else if (PENDING == _status) {
		[userSel setImage:[UIImage imageNamed:@"add_friends_profile_mask_ring_red.png"]];
	}
	*userStatus = _status;
	[self userSelected:num];
	
}
- (void) userSelected:(int)num {
	float animationTime = 0.5;
	UIImageView *userSel, *user;
	CGRect translation;
	int *userStatus = 0;
	
	switch (num) {
		case 0: {
			translation = CGRectMake(20, 10, 65, 65);;
			userStatus = &user0Status;
			userSel = user0_sel;
			user = user0;
		}
			break;
			
		case 1: {
			translation = CGRectMake(125, 10, 65, 65);
			userStatus = &user1Status;
			userSel = user1_sel;
			user = user1;
		}
			break;
		case 2: {
			translation = CGRectMake(230, 10, 65, 65);
			userStatus = &user2Status;
			userSel = user2_sel;
			user = user2;
		}
			break;
		default:
			break;
	}
	//*userStatus = 1;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: animationTime];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDelegate:self];
	//[UIView setAnimationDidStopSelector:@selector(animationContentsFeedVersionFinished)];
	
	userSel.frame = translation;
	user.alpha = 1.0;
	[UIView commitAnimations];

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

	int *userStatus;
	
	switch (num) {
		case 0: {
			
			userSel = user0_sel;
			user = user0;
			userStatus = &user0Status;

		}
			break;
			
		case 1: {

			userSel = user1_sel;
			user = user1;
			userStatus = &user1Status;
			
		}
			break;
		case 2: {
			userSel = user2_sel;
			user = user2;
			userStatus = &user2Status;
			
		}
			break;
		default:
			break;
	}

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
	
	userSel.frame = CGRectMake(340, 10, 65, 65);;
	user.alpha = .5;
	[UIView commitAnimations];
	
}

-(IBAction) user0Click:	(id) sender {
	if (!user0Status) {
		[self selectUser:0 withStatus:0];
		[addFriendsRef friendRequest:row*3];
	}
	else {
		[self userUnselected:0];
	}
}
-(IBAction) user1Click:	(id) sender {
	if (!user1Status) {
		[self selectUser:1 withStatus:0];
		[addFriendsRef friendRequest:row*3+1];
	}
	else {
		[self userUnselected:1];
	}
}
-(IBAction) user2Click:	(id) sender {
	if (!user2Status) {
		[self selectUser:2 withStatus:0];
		[addFriendsRef friendRequest:row*3+2];
	}
	else {
		[self userUnselected:2];
	}
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
			[user0 loadImageAsync:url_str];
			break;
		case 1:
			[user1 loadImageAsync:url_str];
			break;
		case 2:
			[user2 loadImageAsync:url_str];
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
