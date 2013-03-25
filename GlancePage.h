//
//  GlancePage.h
//  Flow
//
//  Created by Paolo Simonazzi on 3/8/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GlancePage : UIViewController <UITableViewDataSource, UITableViewDelegate> {

	NSArray *usersArray;
}

@property (nonatomic, retain) IBOutlet UITableView *friendsTable;

@end
