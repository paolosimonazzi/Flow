//
//  CellForAddingFriends.h
//  Flow
//
//  Created by Paolo Simonazzi on 3/11/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AsynchUIImageView, AddFriends;

enum CellStatus {
	NONE = 0,
	FRIENDSALREADY,
	PENDING
};

@interface cellPart : UIView {
	int userStatus;
	BOOL userSelected;
}
@property (nonatomic, retain) IBOutlet AsynchUIImageView *user;
@property (nonatomic, retain) IBOutlet UIImageView *user_sel;
@property (nonatomic, retain) IBOutlet UILabel *userLabel;
@property (nonatomic, retain) IBOutlet UIButton *userButton;

-(IBAction) userClick:	(id) sender;

@end

@interface CellForAddingFriends : UITableViewCell {
	int user0Status;
	int user1Status;
	int user2Status;
	
	BOOL user0Selected;
	BOOL user1Selected;
	BOOL user2Selected;
	
	int friendToRemove;
	int friendToUnselect;
}



@property (nonatomic, assign) int row;

@property (nonatomic, retain) AddFriends *addFriendsRef;

@property (nonatomic, retain) IBOutlet AsynchUIImageView *user0;
@property (nonatomic, retain) IBOutlet AsynchUIImageView *user1;
@property (nonatomic, retain) IBOutlet AsynchUIImageView *user2;

@property (nonatomic, retain) IBOutlet UIImageView *user0_sel;
@property (nonatomic, retain) IBOutlet UIImageView *user1_sel;
@property (nonatomic, retain) IBOutlet UIImageView *user2_sel;

@property (nonatomic, retain) IBOutlet UILabel *user0Label;
@property (nonatomic, retain) IBOutlet UILabel *user1Label;
@property (nonatomic, retain) IBOutlet UILabel *user2Label;

@property (nonatomic, retain) IBOutlet UIButton *user0Button;
@property (nonatomic, retain) IBOutlet UIButton *user1Button;
@property (nonatomic, retain) IBOutlet UIButton *user2Button;

-(IBAction) userClick:	(id) sender;

- (void) userSelected:(int)num changingStatus:(BOOL)_sta;

- (void) hideItems:(int) num;

- (void) setTextForItem:(int)num text:(NSString*)str;
- (void) setImageUrlForItem:(int)num url:(NSString*)url_str;

- (void) selectStatusCell:(int)_ncell withStatus:(int)_status;

@end
