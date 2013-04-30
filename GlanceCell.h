//
//  CustomCell.h
//  Flow
//
//  Created by Paolo Simonazzi on 3/8/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AsynchUIImageView, GlancePage;

@interface GlanceCell : UITableViewCell {


}
@property (nonatomic, assign) int row;
@property (nonatomic, retain) GlancePage *GlancePageRef;
@property (nonatomic, retain) IBOutlet UIImageView *mask;
@property (nonatomic, retain) IBOutlet AsynchUIImageView *profilePic;
@property (nonatomic, retain) IBOutlet AsynchUIImageView *graphPic;

- (void) acceptanceVersion;
- (void) normalVersion;
- (void) loadingFriendShipVersion;

@property (nonatomic, retain) IBOutlet UIButton *acceptButton;
@property (nonatomic, retain) IBOutlet UIButton *declineButton;

@property (nonatomic, retain) IBOutlet UILabel  *name;

@property (nonatomic, retain) IBOutlet UILabel  *time;
@property (nonatomic, retain) IBOutlet UILabel  *where;

-(IBAction) acceptClick:	(id) sender;
-(IBAction) declineClick:	(id) sender;



@end
