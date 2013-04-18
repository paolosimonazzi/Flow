//
//  ScrollableEvents.h
//  Flow
//
//  Created by Paolo Simonazzi on 4/12/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserContent;

@interface ScrollableEvents : UIScrollView  <UIScrollViewDelegate> {

	int pages;
	NSMutableArray	*contentPages;
	BOOL loading;
}
//@property (nonatomic, assign) int loading;
@property (nonatomic, retain) UserContent *userContentRef;

- (void) scrollAtPage:		(int) _page;
- (void) addEvent:			(UIView*) _event;
- (void) addEvents:			(NSArray*) _events;

- (void) scrollAtPercentage:(float)_percentage;

- (void) flushEvents;
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign) int  numPages;

@end
