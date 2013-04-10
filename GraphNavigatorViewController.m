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

@synthesize slider, waveLine, userContentRef;

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
    [UIView beginAnimations:nil context:NULL]; {
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.2];
		[UIView setAnimationDelegate:self];
        
		//slider.frame = CGRectMake(sliderRect.origin.x,app.y-(sliderRect.size.height/2),sliderRect.size.width,sliderRect.size.height);
		slider.frame = CGRectMake(app.x-(sliderRect.size.width/2), sliderRect.origin.y, sliderRect.size.width, sliderRect.size.height);
		
    }
    [UIView commitAnimations];

}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    sliderRect = slider.frame;
    stripeRect = self.view.frame;
    
    CGPoint app = [touch locationInView:self.view];

	slider.frame = CGRectMake(app.x-(sliderRect.size.width/2), sliderRect.origin.y, sliderRect.size.width, sliderRect.size.height);

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    sliderRect = slider.frame;
    stripeRect = self.view.frame;
	int pageToScrollTo = sliderRect.origin.x*0.025 + 1;
	
	[userContentRef scrollAtPage:pageToScrollTo];
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
