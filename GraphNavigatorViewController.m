//
//  GraphNavigatorViewController.m
//  Flow
//
//  Created by Paolo Simonazzi on 4/10/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "GraphNavigatorViewController.h"
#import "ContentPage.h"

@interface GraphNavigatorViewController ()

@end

@implementation GraphNavigatorViewController

@synthesize slider, waveLine;

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
		
		/*
		float valueGain = [self getGain];
		
		if (valueGain>0.99) {
			valueGain=1;
		} else if (valueGain<=0) {
			valueGain=0;
		}
		[self setGain:valueGain withAnimation:NO];
		 */
    }
    [UIView commitAnimations];

}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    sliderRect = slider.frame;
    stripeRect = self.view.frame;
    
    CGPoint app = [touch locationInView:self.view];
    /*
	 if ([self checkBound:app.y])
	 return;
	 */
    //slider.frame = CGRectMake(sliderRect.origin.x,app.y-(sliderRect.size.height/2),sliderRect.size.width,sliderRect.size.height);
	slider.frame = CGRectMake(app.x-(sliderRect.size.width/2), sliderRect.origin.y, sliderRect.size.width, sliderRect.size.height);

	/*
    float valueGain = [self getGain];
    if (valueGain>0.99) {
        slider.frame = CGRectMake(sliderRect.origin.x,bottomOffsetY,sliderRect.size.width,sliderRect.size.height);
    } else if (valueGain<=0) {
        slider.frame = CGRectMake(sliderRect.origin.x,upOffsetY,sliderRect.size.width,sliderRect.size.height);
    }
	 */
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
