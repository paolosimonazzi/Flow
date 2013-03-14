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
		[image1 loadImageAsync:url_str];
		street1.text = [[_dict objectForKey:@"location"] objectForKey:@"address"];
	} else {
		[image2 loadImageAsync:url_str];
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

- (void) contentsBack:(NSData*)_data {
	
	[self setImage:[UIImage imageWithData:_data]];
}

- (void) loadImageAsync:(NSString*)_url {
	
	Connection *connectionForTheImage = [[Connection alloc] initWithTarget:self withSelector:@selector(contentsBack:)];
	[connectionForTheImage loadImage:_url];

}

@end