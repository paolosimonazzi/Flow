//
//  ViewController.h
//  Flow
//
//  Created by Paolo Simonazzi on 2/21/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

#import "Connection.h"

@class AmazingMenu, GlancePage, GraphNavitor, GraphNavigatorViewController, ScrollableEvents, AsynchUIImageView;


@class GPS;

@interface UserContent : UIViewController <FBLoginViewDelegate, UIScrollViewDelegate, UIPickerViewDataSource> {

	NSMutableArray	*contentPages;
	AmazingMenu		*menu;
	int				numberOfEvents;
	int				numberOfPages;
	unsigned long	lastUser;
}
- (IBAction)postPhotoClick:	(UIButton *)sender;
- (void)	scrollAtPage:		(int) page;
- (void)	getEvents:(unsigned long) _userId;


@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (nonatomic, retain) IBOutlet AsynchUIImageView	*friendPic;

@property (strong, nonatomic) IBOutlet UILabel				*labelFirstName;

@property (nonatomic, retain) IBOutlet UIView				*refreshBackground;
@property (nonatomic, retain) IBOutlet UIImageView			*refreshLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView	*refreshActivityIndicator;

- (void) refresh;

@property (strong, nonatomic) IBOutlet UILabel				*labelPlace;
@property (strong, nonatomic) IBOutlet UILabel				*labelTime;

@property (strong, nonatomic) id<FBGraphUser>				loggedInUser;
@property (nonatomic, retain) GPS *gpsManager;

@property (nonatomic, retain) IBOutlet UILabel				*userName;

@property (nonatomic, retain) GraphNavigatorViewController	*waveLine;

@property (nonatomic, retain) FBLoginView					*loginview;

@property (nonatomic, retain) IBOutlet ScrollableEvents		*scrollView;

@property (nonatomic, retain) IBOutlet UIView				*profileView;

@property (nonatomic, retain) IBOutlet UIView				*splashView;
@property (nonatomic, retain) IBOutlet UIView				*fakeButton;

@property (nonatomic, retain) IBOutlet UIView				*backgroundWaveLine;



@property (nonatomic, retain) GlancePage *glance;

@property (nonatomic, retain) IBOutlet UIPickerView			*usersPicker;

@property (nonatomic, assign) BOOL loading;

- (void) setProfile:(NSDictionary*)_profileData;

@end
