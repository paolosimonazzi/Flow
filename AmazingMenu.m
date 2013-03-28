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

@interface AmazingMenu ()

@end

@implementation AmazingMenu

@synthesize backButton, dotsButton, shareButton, glanceButton,
			status, userContent, addFriends;

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
	shareButton.frame = CGRectMake(90, 0, 40, 40);
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
	
	backButton.frame = CGRectMake(11, 0, 40, 40);
	
	[UIView commitAnimations];
	
}

- (void) profileVersion {

	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationProfileVersionFinished)];

	backButton.frame = CGRectMake(-60, 0, 40, 40);
    
	[UIView commitAnimations];
	
	status = PROFILE;

}
- (void) animationProfileVersionFinished {
	
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
  
	
	glanceButton.frame = CGRectMake(140, 0, 40, 40);
	shareButton.frame = CGRectMake(11, 0, 40, 40);
    
	[UIView commitAnimations];
	
}
- (void) glanceVersion {
	
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 1];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(animationProfileVersionFinished)];
	
	dotsButton.frame = CGRectMake(270, 0, 40, 40);
    shareButton.frame = CGRectMake(-60, 0, 40, 40);
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
-(IBAction) backButtonClick:	(id) sender {
	if (GLANCE == status) {
		[glancePage.view removeFromSuperview];
		status = ADDFRIENDS;
	} else if (ADDFRIENDS == status) {
		[addFriends.view removeFromSuperview];
		status = GLANCE;
	}
}

-(IBAction) glanceButtonClick:	(id) sender {
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
-(IBAction) shareButtonClick:	(id) sender {
	self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];

}

-(IBAction) dotsButtonClick:	(id) sender {
	if (nil == addFriends) {
		addFriends = [[AddFriends alloc] initWithNibName:@"AddFriends" bundle:[NSBundle mainBundle]];
	}
	CGRect frame = addFriends.view.frame;
	addFriends.view.frame = CGRectMake(frame.origin.x, 40, frame.size.width, frame.size.height);
	[userContent.view addSubview:addFriends
	 .view];
	
	[self addFriendsVersion];

}
- (UIView*) getLoadingPage {
	if (nil == addFriends) {
		addFriends = [[AddFriends alloc] initWithNibName:@"AddFriends" bundle:[NSBundle mainBundle]];
	}
	CGRect frame = addFriends.view.frame;
	addFriends.view.frame = CGRectMake(frame.origin.x, 40, frame.size.width, frame.size.height);

	return addFriends.loadingPage;
}
@end
