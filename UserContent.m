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

@implementation UserContent

@synthesize labelFirstName, loggedInUser, profilePic,
gpsManager, userName, scrollView, profileView, glance, usersPicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	usersArray = [[NSMutableArray alloc] init];
	[usersArray addObject:@"Paolo0"];
	[usersArray addObject:@"Paolo1"];
	[usersArray addObject:@"Paolo2"];
	[usersArray addObject:@"Paolo3"];
	[usersArray addObject:@"Paolo4"];
	[usersArray addObject:@"Paolo5"];
	[usersArray addObject:@"Paolo6"];
	[usersArray addObject:@"Paolo7"];
	[usersArray addObject:@"Paolo8"];
	[usersArray addObject:@"Paolo9"];

	self.view.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
	// Do any additional setup after loading the view, typically from a nib.
	// Create Login View so that the app will be granted "status_update" permission.
	
	FBLoginView *loginview = [[FBLoginView alloc] init];
    
    loginview.frame = CGRectOffset(loginview.frame, 86, 360);
    loginview.delegate = self;
    
	scrollView.contentSize = CGSizeMake(3200, 450);
	scrollView.delegate = self;
	scrollView.showsVerticalScrollIndicator    = NO;
    scrollView.showsHorizontalScrollIndicator  = NO;
	
    [loginview sizeToFit];
	
	//gpsManager = [[GPS alloc] init];
	[profileView addSubview:loginview];
	profileView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
	
	[self addEvent:profileView atPage:0];
	
	[self scrollAtPage:9];

	contentPages = [[NSMutableArray alloc] initWithObjects:profileView, nil];

	[self getEvents];
	
	[self menuCreation];
	
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


- (void) scrollAtPage:(int) page {
	
    CGRect scrollRect = CGRectMake(page * 320, 50, 320, 302);
    [scrollView scrollRectToVisible:scrollRect animated:YES];

}
- (void) addEvent:(UIView*) event atPage:(int)page {

	[contentPages addObject:event];
	int pageWide = 320;
	int xPos = (3200-pageWide) - page*pageWide;
	
	event.frame = CGRectMake(event.frame.origin.x + xPos, event.frame.origin.y, event.frame.size.width, event.frame.size.height);
	
	[scrollView addSubview:event];

}

- (void)getEvents {
	
	Connection *someDataConnection = [[Connection alloc] initWithTarget:self withSelector:@selector(contentsBack:)];

	NSString *dateStartStr = @"20130307";
	// Convert string to date object
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyyMMdd"];
	NSDate *dateStart = [dateFormat dateFromString:dateStartStr];

	//NSDate *dateStop = [dateFormat dateFromString:dateStopStr];
	
	NSDate *today = [NSDate dateWithTimeIntervalSinceNow:0];
	
	//NSLog(@"time start: %d time stop %d", (int)[dateStart timeIntervalSince1970], (int)[dateStop timeIntervalSince1970]);

	[someDataConnection getEvents:dateStart stop:today];
}

#pragma mark - picker's shit

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	return [usersArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [usersArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	[User getUser].ID = row + 10;
	NSLog(@"Selected user: %d", [User getUser].ID);

}

#pragma -

#pragma mark - connection

- (void) contentsBack:(NSData*)_data {

	NSError* error;

	NSArray *array = [NSJSONSerialization JSONObjectWithData:_data //1
													 options:kNilOptions
													   error:&error];
	for (int idx = 0; idx<[array count]; ++idx) {
		ContentPage *son = [[ContentPage alloc]
							initWithNibName:@"ContentPage" bundle:[NSBundle mainBundle]];
		[self addEvent:son.view atPage:idx+1];
		//[son loadImage:0 withUrl:nil];
		//[son loadContent: [array objectAtIndex:idx]];
		//[son loadContent:idx withUrl:[array objectAtIndex:idx]];
		[son loadContent:0 withData:[array objectAtIndex:idx]];
		if (idx < [array count]-1) {
			[son loadContent:1 withData:[array objectAtIndex:idx+1]];
			//[son loadImage:idx withUrl:[array objectAtIndex:idx+1]];
			//[son loadContent: [array objectAtIndex:idx+1]];
		}
		if (idx>9)
			break;
	}
}
/*
- (void) dataReceived:(NSData*)data {
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received bytes of data (content)");
	
}
*/


#pragma mark -

#pragma mark - FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    // first get the buttons set for login mode
	NSLog(@"Logged In");
	
}

-(void) loginBack:(NSData*)_data {
	NSError* error;

	NSDictionary *userData = [NSJSONSerialization JSONObjectWithData:_data //1
									options:kNilOptions
									  error:&error];
	
	NSNumber *userId = [userData objectForKey:@"id"];
	NSLog(@"idBack: %d", [userId integerValue]);
	
	[User getUser].ID = [userId integerValue];
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

- (IBAction)changeUser:(UIButton *)sender {
	usersPicker.alpha = usersPicker.alpha>0?0:1;
}

#pragma mark - Scrolling Stuff

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
	
	if (PROFILE == menu.status) {
		[menu contentsFeedVersion];
	} else {
		[menu profileVersion];
	}

}
#pragma mark -

@end
