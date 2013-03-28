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

@synthesize image1, image2, street1, street2;

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
	NSString *url_str = [[[_dict objectForKey:@"media"] objectAtIndex:0] objectForKey:@"url"];
	
	NSString *street_str = [[_dict objectForKey:@"location"] objectForKey:@"address"];
	
	NSLog(@"location dict: %@", street_str);
	if (_num) {

		[image1 loadImageAsync:[url_str stringByReplacingOccurrencesOfString:@"200x200" withString:@"640x336"]];
		
		street1.text = [[_dict objectForKey:@"location"] objectForKey:@"address"];
	} else {
		[image2 loadImageAsync:[url_str stringByReplacingOccurrencesOfString:@"200x200" withString:@"640x336"]];
		street2.text = [[_dict objectForKey:@"location"] objectForKey:@"address"];
	}
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