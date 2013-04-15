//
//  ScrollableEvents.h
//  Flow
//
//  Created by Paolo Simonazzi on 4/12/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollableEvents : UIScrollView  <UIScrollViewDelegate> {

	int pages;
	NSMutableArray	*contentPages;
}
@property (nonatomic, assign) int loading;

- (void) scrollAtPage:	(int) _page;

- (void) addEvent:		(UIView*) event;
- (void) flushEvents;


@end
