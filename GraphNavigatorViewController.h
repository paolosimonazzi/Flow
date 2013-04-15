//
//  GraphNavigatorViewController.h
//  Flow
//
//  Created by Paolo Simonazzi on 4/10/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AsynchUIImageView, UserContent;

@interface GraphNavigatorViewController : UIViewController {

	CGRect          sliderRect;
	CGRect          stripeRect;
}
@property (nonatomic, retain) IBOutlet UIImageView	*slider;
@property (nonatomic, retain) IBOutlet UILabel		*timeLabel;

@property (nonatomic, retain) IBOutlet AsynchUIImageView *waveLine;

@property (nonatomic, retain) UserContent *userContentRef;

- ( void ) loadWaveLine:(NSString*)_url;
- ( void ) setMarkerAtPage:(int) _page;
@end
