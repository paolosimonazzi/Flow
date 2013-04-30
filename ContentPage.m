//
//  ContentViewController.m
//  Flow
//
//  Created by Paolo Simonazzi on 2/28/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "ContentPage.h"
#import "Connection.h"

@interface ContentPage ()

@end

@implementation ContentPage

@synthesize image1, image2, street1, street2, subtitle1_1, subtitle1_2, subtitle2_1, subtitle2_2, dividingLine1, dividingLine2, eventType1, eventType2;

/*
- (id)initWithCoder:(NSCoder *)aDecoder {
	
	if(self = [super initWithCoder:aDecoder]) {
		//self.instanceVariable = [aDecoder decodeObjectForKey:INSTANCEVARIABLE_KEY];
	}
	return self;
}
*/
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.view.backgroundColor = [UIColor colorWithRed:140.0/255.0 green:204.0/255.0 blue:179.0/255.0 alpha:1.0];
		
    }
    return self;
}

- (void) loadContent:(int)_num withData:(NSDictionary*)_dict {

	//NSLog(@"content dict: %@", [_dict description]);

	NSString *url_str = [_dict objectForKey:@"imageUrl"];
	NSString *street_str = [[_dict objectForKey:@"location"] objectForKey:@"address"];

	NSString *imageUrl;
	BOOL iphone5 = [self hasFourInchDisplay];

	if ([url_str rangeOfString:@"place"].location == NSNotFound) {
		//NSLog(@"street!");
		if (iphone5) {
			imageUrl = [url_str stringByReplacingOccurrencesOfString:@"200x200" withString:@"640x408"];
		} else {
			imageUrl = [url_str stringByReplacingOccurrencesOfString:@"200x200" withString:@"640x306"];
		}
	} else {
		//NSLog(@"place!");
		if (iphone5) {
			imageUrl = [url_str stringByReplacingOccurrencesOfString:@"height=200" withString:@"width=640"];
		} else {
			imageUrl = [url_str stringByReplacingOccurrencesOfString:@"height=200" withString:@"width=640"];
		}
	}
	NSArray *lines = [_dict objectForKey:@"lines"];
	//NSLog(@"%@", imageUrl);
	if (_num) {
		
		[image1 loadImageAsync:	imageUrl withSpinner:YES];
		//NSString *ptr = [lines objectAtIndex:0];
		//if ((NSNull *)getCaption == [NSNull null])
		
		eventType1.text		= [NSNull null] != [lines objectAtIndex:0]?[lines objectAtIndex:0]:@"";
		street1.text		= [NSNull null] !=[lines objectAtIndex:1]?[lines objectAtIndex:1]:@"";
		subtitle1_1.text	= [NSNull null] !=[lines objectAtIndex:2]?[lines objectAtIndex:2]:@"";
		subtitle1_2.text	= [NSNull null] !=[lines objectAtIndex:3]?[lines objectAtIndex:3]:@"";
	} else {
		[image2 loadImageAsync:imageUrl withSpinner:YES];
		eventType2.text		= [NSNull null] != [lines objectAtIndex:0]?[lines objectAtIndex:0]:@"";
		street2.text		= [NSNull null] !=[lines objectAtIndex:1]?[lines objectAtIndex:1]:@"";
		subtitle2_1.text	= [NSNull null] !=[lines objectAtIndex:2]?[lines objectAtIndex:2]:@"";
		subtitle2_2.text	= [NSNull null] !=[lines objectAtIndex:3]?[lines objectAtIndex:3]:@"";
	}
}
/*
 [image2 loadImageAsync:[url_str stringByReplacingOccurrencesOfString:@"200x200" withString:@"640x336"]];
 */

- (BOOL)hasFourInchDisplay {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// setting fonts
	street1.font = [UIFont fontWithName:@"BrandonGrotesque-Black" size:24];//[UIFont fontWithName:@"BrandonGrotesque-MediumItalic" size:18];
	street2.font = [UIFont fontWithName:@"BrandonGrotesque-Black" size:24];
	
	eventType1.font = [UIFont fontWithName:@"BrandonGrotesque-Black" size:16];

	eventType2.font = [UIFont fontWithName:@"BrandonGrotesque-Black" size:16];

	subtitle2_2.font = [UIFont fontWithName:@"BrandonGrotesque-MediumItalic" size:12];
	subtitle2_1.font = [UIFont fontWithName:@"BrandonGrotesque-MediumItalic" size:12];
	subtitle1_2.font = [UIFont fontWithName:@"BrandonGrotesque-MediumItalic" size:12];
	subtitle1_1.font = [UIFont fontWithName:@"BrandonGrotesque-MediumItalic" size:12];
	
	int offset4Inch = 40;
	
	if ([self hasFourInchDisplay]) {
		self.view.frame = CGRectMake(0, 0, 320, 400);
		image1.frame = CGRectMake(0, 0, 320, 204);
		image2.frame = CGRectMake(0, 204, 320, 180);
		
		street2.frame = CGRectMake(street2.frame.origin.x, street2.frame.origin.y+offset4Inch, street1.frame.size.width, street1.frame.size.height);
		subtitle2_1.frame = CGRectMake(subtitle2_1.frame.origin.x, subtitle2_1.frame.origin.y+offset4Inch, subtitle2_1.frame.size.width, subtitle2_1.frame.size.height);
		subtitle2_2.frame = CGRectMake(subtitle2_2.frame.origin.x, subtitle2_2.frame.origin.y+offset4Inch, subtitle2_2.frame.size.width, subtitle2_2.frame.size.height);
		dividingLine2.frame = CGRectMake(dividingLine2.frame.origin.x, dividingLine2.frame.origin.y+offset4Inch, dividingLine2.frame.size.width, dividingLine2.frame.size.height);
	} else {
		//street2.frame = CGRectMake(40, 180, street1.frame.size.width, street1.frame.size.height);

		self.view.frame = CGRectMake(0, 0, 320, 305);
		image1.frame = CGRectMake(0, 0, 320, 153);
		image2.frame = CGRectMake(0, 153, 320, 153);
	}

	//self.view.frame = CGRectMake(0, 0, 320, 383);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
@implementation AsynchUIImageView

@synthesize activityIndicator;

/*
- (id) init {
	self = [super init];
	self.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:0.0];

	return self;
}
*/
- (void) fadeIn {
	
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];

	self.alpha = 1;
	
	[UIView commitAnimations];

}

- (void) contentsBack:(NSData*)_data {

	self.alpha = 0;
	if (activityIndicator)
		[activityIndicator removeFromSuperview];
	[self setImage:[UIImage imageWithData:_data]];
	
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1
									 target:self
								   selector:@selector(fadeIn)
								   userInfo:nil
									repeats:NO];
}
- (void) blankImage {
	[self setImage:nil];
}
- (void) placeHolder {
	[self setImage:[UIImage imageNamed:@"profile_placeholder"]];
}

- (void) loadImageAsync:(NSString*)_url withSpinner:(BOOL) _spinner {
	/*
	self.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:0.0];
	 
	self.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:245.0/255.0 blue:232.0/255.0 alpha:1.0];
*/
	//[self setImage:[UIImage imageNamed:@"profile_placeholder"]];
	Connection *connectionForTheImage = [[Connection alloc] initWithTarget:self withSelector:@selector(contentsBack:)];
	[connectionForTheImage loadImage:_url];
	
	// create activity indicator
	if (!_spinner)
		return;
	if (!activityIndicator) {
		CGRect myRect = self.frame;
		activityIndicator = [[UIActivityIndicatorView alloc]
												  initWithFrame:CGRectMake(myRect.size.width/2-10, myRect.size.height/2-10, 20.0f, 20.0f)];
		[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
	}
	
	[self addSubview:activityIndicator];
	[activityIndicator stopAnimating];
	
}

@end