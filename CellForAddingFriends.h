//
//  CellForAddingFriends.h
//  Flow
//
//  Created by Paolo Simonazzi on 3/11/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AsynchUIImageView, AddFriends;

@interface CellForAddingFriends : UITableViewCell {
	int user0Status;
	int user1Status;
	int user2Status;
}

- (void) selectUser:(int)num withStatus:(int)_status;

@property (nonatomic, assign) int row;

@property (nonatomic, retain) IBOutlet AddFriends *addFriendsRef;

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

-(IBAction) user0Click:	(id) sender;
-(IBAction) user1Click:	(id) sender;
-(IBAction) user2Click:	(id) sender;


- (void) userSelected:(int) num;
- (void) hideItems:(int) num;

- (void) setTextForItem:(int)num text:(NSString*)str;
- (void) setImageUrlForItem:(int)num url:(NSString*)url_str;
@end
