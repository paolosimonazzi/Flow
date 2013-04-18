//
//  AmazingMenu.m
//  Flow
//
//  Created by Paolo Simonazzi on 3/6/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "AmazingMenu.h"
#import "GlancePage.h"
#import "UserContent.h"
#import "AddFriends.h"
#import "Settings.h"

#import "User.h"
@interface AmazingMenu ()

@end

@implementation AmazingMenu

@synthesize backButton, dotsButton, addFriendsButton, glanceButton,
			status, userContent, addFriends, settings;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		status = PROFILE;
		
		self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
    }
    return self;
}
- (void) contentsFeedVersion {
	
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationContentsFeedVersionFinished)];
    
	
	glanceButton.frame = CGRectMake(178, 0, 40, 40);
	addFriendsButton.frame = CGRectMake(90, 0, 40, 40);
	backButton.frame = CGRectMake(11, 0, 40, 40);
    
	[UIView commitAnimations];
	
	status = CONTENTS;

}
- (void) animationCompressFinished {
	
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(animationFinished)];
	
	//backButton.frame = CGRectMake(11, 0, 40, 40);
	
	[UIView commitAnimations];
	
}

- (void) profileVersion {

	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationProfileVersionFinished)];

	backButton.frame = CGRectMake(-60, 0, 40, 40);
	dotsButton.frame = CGRectMake(270, 0, 40, 40);
	addFriendsButton.frame = CGRectMake(340, 0, 40, 40);
    
	[UIView commitAnimations];
	
	status = PROFILE;

}
- (void) animationProfileVersionFinished {
	
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
  
	
	//glanceButton.frame = CGRectMake(140, 0, 40, 40);
	//addFriendsButton.frame = CGRectMake(11, 0, 40, 40);
    
	[UIView commitAnimations];
	
}
- (void) glanceVersion {
	
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 1];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(animationProfileVersionFinished)];
	
	dotsButton.frame = CGRectMake(340, 0, 40, 40);
    addFriendsButton.frame = CGRectMake(270, 0, 40, 40);
	backButton.frame = CGRectMake(11, 0, 40, 40);
	[UIView commitAnimations];
	
	status = GLANCE;
	
}

- (void) addFriendsVersion {

	status = ADDFRIENDS;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction) backButtonClick:(id) sender {
	if (GLANCE == status) {
		[glancePage.view removeFromSuperview];
		[self profileVersion];
	} else if (ADDFRIENDS == status) {
		[addFriends.view removeFromSuperview];
		[self glanceVersion];
	} else if (FRIENDEVENTS == status) {
		[userContent getEvents:[User getUser].ID];
		[self profileVersion];
	}
}

-(IBAction) glanceButtonClick:(id) sender {
	if(nil == glancePage) {
		glancePage = [[GlancePage alloc]
				  initWithNibName:@"GlancePage" bundle:[NSBundle mainBundle]];
	}
	glancePage.menuRef = self;

	CGRect frame = glancePage.view.frame;
	glancePage.view.frame = CGRectMake(frame.origin.x, 40, frame.size.width, frame.size.height);
	[userContent.view addSubview:glancePage.view];
	[self glanceVersion];

}

- (void) friendEventsVersion:(unsigned long) _friendId {
	status = FRIENDEVENTS;
	[glancePage.view removeFromSuperview];
	[userContent getEvents:_friendId];
}

- (IBAction) addFriendsButtonClick:	(id) sender {
	/*
	self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
	 */
	if (nil == addFriends) {
		addFriends = [[AddFriends alloc] initWithNibName:@"AddFriends" bundle:[NSBundle mainBundle]];
	}
	CGRect frame = addFriends.view.frame;
	addFriends.view.frame = CGRectMake(frame.origin.x, 40, frame.size.width, frame.size.height);
	[userContent.view addSubview:addFriends
	 .view];
	
	[self addFriendsVersion];
}

- (IBAction) dotsButtonClick:	(id) sender {
	static BOOL loginButtonOn = NO;
	/*
	if (nil == settings) {
		settings = [[Settings alloc] initWithNibName:@"Settings" bundle:[NSBundle mainBundle]];
	}
	CGRect frame = settings.view.frame;
	settings.view.frame = CGRectMake(frame.origin.x, 40, frame.size.width, frame.size.height);
	[userContent.view addSubview:settings.view];
	
	//[self addFriendsVersion];
*/
/*
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 1];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
	if (loginButtonOn) {
		userContent.loginview.frame = CGRectOffset(userContent.loginview.frame, +284, 0);
		loginButtonOn = NO;
	} else {
		loginButtonOn = YES;
		userContent.loginview.frame = CGRectOffset(userContent.loginview.frame, -284, 0);
	}
	[UIView commitAnimations];
 */
}
- (UIView*) getLoadingPage {
	if (nil == addFriends) {
		addFriends = [[AddFriends alloc] initWithNibName:@"AddFriends" bundle:[NSBundle mainBundle]];
	}
	CGRect frame = addFriends.view.frame;
	CGRect Loadframe = addFriends.loadingPage.frame;
	addFriends.view.frame = CGRectMake(frame.origin.x, 40, frame.size.width, frame.size.height);
	addFriends.loadingPage.frame = CGRectMake(Loadframe.origin.x, 3, Loadframe.size.width, Loadframe.size.height);
	return addFriends.loadingPage;
}
@end
