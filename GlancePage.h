//
//  GlancePage.h
//  Flow
//
//  Created by Paolo Simonazzi on 3/8/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AmazingMenu;

@interface GlancePage : UIViewController <UITableViewDataSource, UITableViewDelegate> {

	NSArray *usersArray;
}

@property (nonatomic, retain) IBOutlet UITableView *friendsTable;
@property (nonatomic, retain) IBOutlet UIImageView *bottomLine;
@property (nonatomic, retain) AmazingMenu *menuRef;

@property (nonatomic, retain) UIView *loadingPage;
- (void) acceptFriendship:(int) _row;
- (void) declineFriendship:(int) _row;


@end
