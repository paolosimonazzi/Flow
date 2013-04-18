//
//  AmazingMenu.h
//  Flow
//
//  Created by Paolo Simonazzi on 3/6/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>

enum MenuStatus {
	PROFILE = 0,
	CONTENTS,
	GLANCE,
	ADDFRIENDS,
	FRIENDEVENTS
};

@class GlancePage, UserContent, AddFriends, Settings;

@interface AmazingMenu : UIViewController {
	
	int status;
		
	GlancePage *glancePage;
	
}

@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) IBOutlet UIButton *glanceButton;
@property (nonatomic, retain) IBOutlet UIButton *addFriendsButton;
@property (nonatomic, retain) IBOutlet UIButton *dotsButton;

@property (nonatomic, assign) int status;

@property (nonatomic, retain) UserContent	*userContent;
@property (nonatomic, retain) AddFriends	*addFriends;
@property (nonatomic, retain) Settings		*settings;


- (void) contentsFeedVersion;
- (void) profileVersion;
- (void) friendEventsVersion:(unsigned long)_friendId;

-(IBAction) backButtonClick:		(id) sender;
-(IBAction) glanceButtonClick:		(id) sender;
-(IBAction) addFriendsButtonClick:	(id) sender;
-(IBAction) dotsButtonClick:		(id) sender;

- (UIView*) getLoadingPage;

@end
