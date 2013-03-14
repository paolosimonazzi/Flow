//
//  CellForAddingFriends.h
//  Flow
//
//  Created by Paolo Simonazzi on 3/11/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellForAddingFriends : UITableViewCell {
	int user0Status;
	int user1Status;
	int user2Status;
}
- (void) selectUser:(int)num;

@property (nonatomic, retain) IBOutlet UIImageView *user0;
@property (nonatomic, retain) IBOutlet UIImageView *user1;
@property (nonatomic, retain) IBOutlet UIImageView *user2;

@property (nonatomic, retain) IBOutlet UIImageView *user0_sel;
@property (nonatomic, retain) IBOutlet UIImageView *user1_sel;
@property (nonatomic, retain) IBOutlet UIImageView *user2_sel;

-(IBAction) user0Click:	(id) sender;
-(IBAction) user1Click:	(id) sender;
-(IBAction) user2Click:	(id) sender;


- (void) userSelected:(int)num;

@end
