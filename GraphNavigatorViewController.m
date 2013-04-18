//
//  GraphNavigatorViewController.m
//  Flow
//
//  Created by Paolo Simonazzi on 4/10/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "GraphNavigatorViewController.h"
#import "ContentPage.h"
#import "UserContent.h"
@interface GraphNavigatorViewController ()

@end

@implementation GraphNavigatorViewController

@synthesize slider, waveLine, userContentRef, timeLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	UITouch *touch = [touches anyObject];
    sliderRect = slider.frame;
    stripeRect = self.view.frame;
    CGPoint app = [touch locationInView:self.view];
	/*
    if ([self checkBound:app.y])
        return;
	 */
	fireEnabled = YES;

	[UIView beginAnimations:nil context:NULL]; {
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
   	timeLabel.alpha = 1;
    
	//slider.frame = CGRectMake(sliderRect.origin.x,app.y-(sliderRect.size.height/2),sliderRect.size.width,sliderRect.size.height);
	slider.frame = CGRectMake(app.x-(sliderRect.size.width/2), sliderRect.origin.y, sliderRect.size.width, sliderRect.size.height);
		
    }
    [UIView commitAnimations];
}
- ( void ) blankWaveLine {
	[waveLine blankImage];
}

bool fireEnabled = NO;

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    sliderRect = slider.frame;
    stripeRect = self.view.frame;
    fireEnabled = YES;
    CGPoint app = [touch locationInView:self.view];

	slider.frame = CGRectMake(app.x-(sliderRect.size.width/2), sliderRect.origin.y, sliderRect.size.width, sliderRect.size.height);
}
- ( void ) setMarkerAt:(float) _absolutePosition {

	sliderRect = slider.frame;
	fireEnabled = NO;
	[UIView beginAnimations:nil context:NULL]; {
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
		slider.frame = CGRectMake( _absolutePosition*320,  sliderRect.origin.y,sliderRect.size.width, sliderRect.size.height);
	}
	[UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    sliderRect = slider.frame;
    stripeRect = self.view.frame;
	int pageToScrollTo = sliderRect.origin.x * 0.025 + 1;
	float perc = 1 - (sliderRect.origin.x+sliderRect.size.width/2)/320;
	//[userContentRef scrollAtPage:pageToScrollTo];
	if (fireEnabled)
		[userContentRef scrollContents:perc];
	NSLog(@"nagitator percentage: %f",perc);
	[UIView beginAnimations:nil context:NULL]; {
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelegate:self];
		timeLabel.alpha = 0;
	}
	[UIView commitAnimations];
}

-(void) loadWaveLine:(NSString*)_url {
	
	[waveLine loadImageAsync:_url withSpinner:NO];	

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
