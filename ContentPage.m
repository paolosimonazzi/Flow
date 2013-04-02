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

@synthesize image1, image2, street1, street2, subtitle1_1, subtitle1_2, subtitle2_1, subtitle2_2;

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
	
	if ([url_str rangeOfString:@"place"].location == NSNotFound) {
		NSLog(@"street!");
		imageUrl = [url_str stringByReplacingOccurrencesOfString:@"200x200" withString:@"640x336"];
	} else {
		NSLog(@"place!");
		imageUrl = [url_str stringByReplacingOccurrencesOfString:@"height=200" withString:@"width=640"];
	}
	
	NSLog(@"%@", imageUrl);
	
	if (_num) {
		
		[image1 loadImageAsync:	imageUrl];
		street1.text = [_dict objectForKey:@"title"];
		subtitle1_1.text = [_dict objectForKey:@"subtitle1"];
		subtitle1_2.text = [_dict objectForKey:@"subtitle2"];

	} else {
		[image2 loadImageAsync:imageUrl];
		street2.text = [_dict objectForKey:@"title"];
		subtitle2_1.text = [_dict objectForKey:@"subtitle1"];
		subtitle2_2.text = [_dict objectForKey:@"subtitle2"];

	}
}
/*
 [image2 loadImageAsync:[url_str stringByReplacingOccurrencesOfString:@"200x200" withString:@"640x336"]];
 */

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

@end
@implementation AsynchUIImageView

@synthesize activityIndicator;
- (void) contentsBack:(NSData*)_data {
	
	[self setImage:[UIImage imageWithData:_data]];
	
	[activityIndicator removeFromSuperview];
}

- (void) loadImageAsync:(NSString*)_url {
	
	Connection *connectionForTheImage = [[Connection alloc] initWithTarget:self withSelector:@selector(contentsBack:)];
	[connectionForTheImage loadImage:_url];
	
	// create activity indicator
	if (!activityIndicator) {
		CGRect myRect = self.frame;

		activityIndicator = [[UIActivityIndicatorView alloc]
												  initWithFrame:CGRectMake(myRect.size.width/2-10, myRect.size.height/2-10, 20.0f, 20.0f)];
		[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
	}
	
	[self addSubview:activityIndicator];
	[activityIndicator startAnimating];

}

@end