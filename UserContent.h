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

@class AmazingMenu, GlancePage, AsynchUIImageView;


@class GPS;

@interface UserContent : UIViewController <FBLoginViewDelegate, UIScrollViewDelegate, UIPickerViewDataSource> {

	NSMutableArray	*contentPages;
	AmazingMenu		*menu;
	NSMutableArray	*usersArray;
	
}
- (IBAction)postPhotoClick:	(UIButton *)sender;
- (IBAction)refresh:		(UIButton *)sender;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel				*labelFirstName;
@property (strong, nonatomic) id<FBGraphUser>				loggedInUser;
@property (nonatomic, retain) GPS *gpsManager;

@property (nonatomic, retain) IBOutlet UILabel				*userName;

@property (nonatomic, retain) IBOutlet AsynchUIImageView	*graphImage;

@property (nonatomic, retain) FBLoginView					*loginview;

@property (nonatomic, retain) IBOutlet UIScrollView			*scrollView;

@property (nonatomic, retain) IBOutlet UIView				*profileView;

@property (nonatomic, retain) IBOutlet UIView				*splashView;


@property (nonatomic, retain) GlancePage *glance;

@property (nonatomic, retain) IBOutlet UIPickerView			*usersPicker;

@property (nonatomic, assign) BOOL loading;
@end
