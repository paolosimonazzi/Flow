//
//  CustomCell.h
//  Flow
//
//  Created by Paolo Simonazzi on 3/8/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AsynchUIImageView;

@interface GlanceCell : UITableViewCell {


}
@property (nonatomic, retain) IBOutlet UIImageView *mask;
@property (nonatomic, retain) IBOutlet AsynchUIImageView *profilePic;
@property (nonatomic, retain) IBOutlet AsynchUIImageView *graphPic;


@end
