//
//  ContentViewController.h
//  Flow
//
//  Created by Paolo Simonazzi on 2/28/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AsynchUIImageView : UIImageView {
	
}

-(void) loadImageAsync:(NSString*)_url;

@end


@interface ContentPage : UIViewController {

}

- (void) loadContent:(int)_num withData:(NSDictionary*)_dict;


@property (nonatomic, retain) IBOutlet AsynchUIImageView *image1;

@property (nonatomic, retain) IBOutlet AsynchUIImageView *image2;

@property (nonatomic, retain) IBOutlet UILabel *street1;

@property (nonatomic, retain) IBOutlet UILabel *street2;

@end

