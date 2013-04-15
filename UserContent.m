//
//  ViewController.m
//  Flow
//
//  Created by Paolo Simonazzi on 2/21/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "UserContent.h"
#import "AppDelegate.h"

#import "GPS.h"
#import "ContentPage.h"
#import "AmazingMenu.h"
#import "GlancePage.h"
#import "User.h"

#import "GraphNavigatorViewController.h"
#import "ScrollableEvents.h"

@implementation UserContent

@synthesize labelFirstName, loggedInUser, profilePic,
gpsManager, userName, scrollView, profileView, glance, usersPicker, loginview, loading, splashView, fakeButton, labelPlace, labelTime, refreshBackground, refreshLabel, refreshActivityIndicator, waveLine, backgroundWaveLine;


- (void) createCustomFBLogin {
	
	splashView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];

	[self.view addSubview:splashView];
	
	//loginview = [[FBLoginView alloc] initWithPermissions:[NSArray arrayWithObject:@"publish_actions"]];
	loginview = [[FBLoginView alloc] init];
	
	//loginview.frame = CGRectOffset(loginview.frame, 150, 50);
	loginview.alpha = 1;
	loginview.frame = CGRectMake(90, 310, 206, 306);
	int numSubviews = [loginview.subviews count];
	for (id obj in loginview.subviews)
	{
		if ([obj isKindOfClass:[UIButton class]])
		{
			UIButton * loginButton =  obj;
			UIImage *loginImage = [UIImage imageNamed:@""];//@"accept_invitation_button_unpressed"];
			[loginButton setBackgroundImage:loginImage forState:UIControlStateNormal];
			[loginButton setBackgroundImage:nil forState:UIControlStateSelected];
			[loginButton setBackgroundImage:nil forState:UIControlStateHighlighted];
			//[loginButton sizeToFit];

			loginButton.frame = CGRectMake(0, 0, 206, 306);
		}
		if ([obj isKindOfClass:[UILabel class]])
		{
			UILabel * loginLabel =  obj;
			loginLabel.text = @"ye";
			loginLabel.textAlignment = UITextAlignmentCenter;
			loginLabel.frame = CGRectMake(0, 0, 271, 200);
		}
	}
    loginview.delegate = self;
    [loginview sizeToFit];
	[splashView addSubview:loginview];
	//[profileView addSubview:loginview];
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];

	fakeButton.alpha = 1;

	[UIView commitAnimations];
}
/*
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if ( event.subtype == UIEventSubtypeMotionShake ) {
    	NSLog(@"Shake!");
    }
	
    if ([super respondsToSelector:@selector(motionEnded:withEvent:)]) {
        [super motionEnded:motion withEvent:event];
    }
}
*/

- (BOOL)hasFourInchDisplay {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
}
- (void) configureWaveLine {
	waveLine = [[GraphNavigatorViewController alloc] initWithNibName:@"GraphNavigatorViewController" bundle:[NSBundle mainBundle]];
	CGRect waveLineRect = waveLine.view.frame;
	waveLine.userContentRef = self;
	if ([self hasFourInchDisplay]) {
		waveLine.view.frame = CGRectMake(0, 423, waveLineRect.size.width, waveLineRect.size.height);
	} else {
		waveLine.view.frame = CGRectMake(0, 335, waveLineRect.size.width, waveLineRect.size.height);
	}
	[self.view addSubview:waveLine.view];

}
/*
- (void) configureScrollContent:(int) _numEvents {

	int sizeOfcontent = _numEvents * 320;
	scrollView.contentSize = CGSizeMake(sizeOfcontent, 305);
	
}
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self configureWaveLine];
	
	self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
	self.refreshBackground.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
	
	self.backgroundWaveLine.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
	 
	// Do any additional setup after loading the view, typically from a nib.
	// Create Login View so that the app will be granted "status_update" permission.
	[self createCustomFBLogin];
    

	
	gpsManager = [[GPS alloc] init];
	profileView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
	

	[scrollView addEvent:profileView];

	//[self scrollAtPage:9];
	
	//[self scrollAtPage:1];
	
	//contentPages = [[NSMutableArray alloc] initWithObjects:profileView, nil];
	
	//[self menuCreation];
	
	UIFont* font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:20];
	NSArray *names = [UIFont fontNamesForFamilyName:@"Brandon Grotesque"];

	labelPlace.font = [UIFont fontWithName:@"BrandonGrotesque-Black" size:30];
	labelTime.font = [UIFont fontWithName:@"BrandonGrotesque-MediumItalic" size:18];
}

- (void) menuCreation {
	
	// menu creation
	menu = [[AmazingMenu alloc]
			initWithNibName:@"AmazingMenu" bundle:[NSBundle mainBundle]];
	
	menu.view.frame = CGRectMake(0, -70, menu.view.frame.size.width, menu.view.frame.size.height);
	[self.view addSubview:menu.view];
	
	[self animationMenu];
	//
	menu.userContent = self;
}

- (void) animationMenu {

	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(animationFinished)];
    
    //slidingView.frame = CGRectMake(xOffset, rect.origin.y, rect.size.width, rect.size.height);

	menu.view.frame = CGRectMake(0, 0, menu.view.frame.size.width, menu.view.frame.size.height);

    [UIView commitAnimations];
}
/*
- (void) scrollAtPage:(int) page {
	int limit = (numberOfPages - page) * 320;
    CGRect scrollRect = CGRectMake (limit * 320, 50, 320, 302);
    [scrollView scrollRectToVisible:scrollRect animated:YES];
}
*/
- (void) scrollAtRefreshing {
	CGRect scrollRect = CGRectMake(2050, 50, 320, 302);
    [scrollView scrollRectToVisible:scrollRect animated:YES];
}
/*
- (void) flushEvents {
	NSLog(@"flush events");
	for (int idx = 0; idx<[contentPages count]; idx++) {
		UIView *pageToFlush = [contentPages objectAtIndex:idx];
		[pageToFlush removeFromSuperview];
	}
	[contentPages removeAllObjects];
}
*/
/*
- (void) addEvent:(UIView*) event atPage:(int)page {
	
	[contentPages addObject:event];
	int pageWide = 320;
	int xPos = (numberOfPages*pageWide-pageWide) - page*pageWide;
	
	event.frame = CGRectMake(event.frame.origin.x + xPos, event.frame.origin.y, event.frame.size.width, event.frame.size.height);
	[scrollView addSubview:event];
}
*/
- (void)getEvents {
	
	[scrollView flushEvents];
	
	scrollView.loading = loading = YES;
	Connection *someDataConnection = [[Connection alloc] initWithTarget:self withSelector:@selector(eventsBack:)];

	NSString *dateStartStr = @"20130307";
	// Convert string to date object
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyyMMdd"];
		
	NSDate *today = [NSDate dateWithTimeIntervalSinceNow:0];
	NSDate *h24Early = [NSDate dateWithTimeIntervalSinceNow:-266400]; //-86400
	//NSLog(@"time start: %d time stop %d", (int)[dateStart timeIntervalSince1970], (int)[dateStop timeIntervalSince1970]);
	[someDataConnection getEvents:h24Early stop:today];
	
}

#pragma mark - connection
#define FIRSTCONTENT 0
#define SECONDCONTENT 1

- (void) eventsBack:(NSData*)_data {

	NSError* error;

	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:_data //1
													 options:kNilOptions
													   error:&error];
	NSArray *array	= [dict objectForKey:@"eventViews"];
	
	labelPlace.text = [dict objectForKey:@"recentLocationName"];
	labelTime.text	= [dict objectForKey:@"recentLocationTime"];

	loading = NO;
	numberOfEvents = [array count];
	//numberOfEvents = 2;
	numberOfPages = numberOfEvents/2;
	NSLog(@"num of events: %d", numberOfEvents);
	//[self configureScrollContent:numberOfEvents];
	//[scrollView setSize:numberOfPages];
	//[self addEvent:profileView atPage:0];
	[scrollView addEvent:profileView];
	
	for (int idx = 0; idx < numberOfEvents; idx+=2) {
		
		ContentPage *son = [[ContentPage alloc]	initWithNibName:@"ContentPage" bundle:[NSBundle mainBundle]];

		[son loadContent:FIRSTCONTENT withData:[array objectAtIndex:idx]];
		if (idx < [array count]-1) {
			[son loadContent:SECONDCONTENT withData:[array objectAtIndex:idx+1]];
		}
		if (idx>16)
			break;
		
		//[self addEvent:son.view atPage:idx/2+1];
		[scrollView addEvent:son.view];

	}
	NSLog(@"waveLine: %@", [dict objectForKey:@"wavelineImageUrl"]);
	[waveLine loadWaveLine:[dict objectForKey:@"wavelineImageUrl"]];

	[refreshActivityIndicator stopAnimating];
	[scrollView scrollAtPage:0];
}
#pragma mark -

#pragma mark - FBLoginViewDelegate
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    // first get the buttons set for login mode
	NSLog(@"Logged In");
	[self menuCreation];
	[splashView removeFromSuperview];
}

-(void) loginBack:(NSData*)_data {
	NSError* error;

	NSDictionary *userData = [NSJSONSerialization JSONObjectWithData:_data //1
									options:kNilOptions
									  error:&error];
	
	NSNumber *userId = [userData objectForKey:@"id"];
	NSLog(@"idBack: %d", [userId integerValue]);
	
	[User getUser].ID = [userId integerValue];

	[self getEvents];

}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    //self.labelFirstName.text = [NSString stringWithFormat:@"Hello %@!", user.first_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
	self.profilePic.pictureCropping = FBProfilePictureCroppingSquare;
	//profilePic.bounds = CGRectMake(0, 0, 220, 220);
    self.profilePic.profileID = user.id;
	self.userName.text	= user.first_name;
	self.userName.font = [UIFont fontWithName:@"BrandonGrotesque-Light" size:23];
    self.loggedInUser	= user;
	
	NSLog(@"user Id %@",user.id);
	
	//NSString * accessToken = [[FBSession activeSession] accessToken];
	
	//NSLog(@"facebook Token:%@", accessToken);
	Connection *login = [[Connection alloc] initWithTarget:self withSelector:@selector(loginBack:)];

	[login loging:user.id withToken:[[FBSession activeSession] accessToken ]];
	
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    //BOOL canShareAnyhow = [FBNativeDialogs canPresentShareDialogWithSession:nil];
    /*
	self.buttonPostPhoto.enabled = canShareAnyhow;
    self.buttonPostStatus.enabled = canShareAnyhow;
    self.buttonPickFriends.enabled = NO;
    self.buttonPickPlace.enabled = NO;
	*/
    self.profilePic.profileID = nil;
    self.labelFirstName.text = nil;
    self.loggedInUser = nil;
	NSLog(@"Logged out");
}
#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)postPhotoClick:(UIButton *)sender {
	/*
	 AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	
	if (appDelegate.session.state != FBSessionStateCreated) {
		// Create a new, logged out session.
		appDelegate.session = [[FBSession alloc] init];
	}
	
	// if the session isn't open, let's open it now and present the login UX to the user
	[appDelegate.session openWithCompletionHandler:^(FBSession *session,
													 FBSessionState status,
													 NSError *error) {
		// and here we make sure to update our UX according to the new session state
		[self updateView];
	}];
*/
	
}

- (IBAction)refresh:(UIButton *)sender {
//	[self scrollAtRefreshing];
	//scrollView.contentOffset = CGPointMake(2910, 0);
}
/*
#pragma mark - Scrolling Stuff

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)_scrollView {
	
}


- (void) refreshTimer:(NSTimer*)_timer {
	loading = NO;
	//scrollView.contentOffset = CGPointMake(2880, 0);
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	
	NSLog(@"%f", scrollView.contentOffset.x);
	if ( scrollView.contentOffset.x > 380) { //2910
		
		if (!loading) {
			//[self getEvents];
		}
	}
	if (loading) {
		//scrollView.contentOffset = CGPointMake((numberOfEvents-1)*320, 0);
		NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5
														  target:self
														selector:@selector(refreshTimer:)
														userInfo:nil
														 repeats:NO];
		//[refreshActivityIndicator startAnimating];
	}
	int page = scrollView.contentOffset.x*0.003 + 0;
	//NSLog(@"scroll: %f, page: %d", scrollView.contentOffset.x, page);
	//[waveLine setMarkerAtPage:page];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
	
	NSLog(@"finish");
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	
	//[waveLine setMarkerAtPage:scrollView.contentOffset.x/480];
}


#pragma mark -
*/
@end
