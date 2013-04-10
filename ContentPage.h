//
//  ContentViewController.h
//  Flow
//
//  Created by Paolo Simonazzi on 2/28/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>
///////////////////////////////////////////////////////////////////////////////////
// async beautiful image
@interface AsynchUIImageView : UIImageView {
	
}

-(void) loadImageAsync:(NSString*)_url withSpinner:(BOOL) _spinner;

@property (nonatomic, retain)	UIActivityIndicatorView *activityIndicator;

@end

///////////////////////////////////////////////////////////////////////////////////
@interface ContentPage : UIViewController {

}

- (void) loadContent:(int)_num withData:(NSDictionary*)_dict;


@property (nonatomic, retain) IBOutlet AsynchUIImageView *image1;

@property (nonatomic, retain) IBOutlet AsynchUIImageView *image2;

@property (nonatomic, retain) IBOutlet UILabel *street1;
@property (nonatomic, retain) IBOutlet UILabel *subtitle1_1;
@property (nonatomic, retain) IBOutlet UILabel *subtitle1_2;


@property (nonatomic, retain) IBOutlet UILabel *street2;
@property (nonatomic, retain) IBOutlet UILabel *subtitle2_1;
@property (nonatomic, retain) IBOutlet UILabel *subtitle2_2;


@end

