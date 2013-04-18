//
//  ScrollableEvents.m
//  Flow
//
//  Created by Paolo Simonazzi on 4/12/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "ScrollableEvents.h"
#import "UserContent.h"
#import "User.h"

@implementation ScrollableEvents

const int refreshAsset = 45;

@synthesize userContentRef, loading, numPages;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
	
	if(self = [super initWithCoder:aDecoder]) {
		//self.instanceVariable = [aDecoder decodeObjectForKey:INSTANCEVARIABLE_KEY];		
		self.showsVerticalScrollIndicator    = NO;
		self.showsHorizontalScrollIndicator  = NO;
		self.delegate = (ScrollableEvents*)self;
		pages = 0;
		contentPages = [[NSMutableArray alloc] initWithObjects: nil];
		loading = NO;
	}
	return self;
}

- (void) scrollAtPage:(int) page {
	int limit = (pages - page - 1) * 320;
    CGRect scrollRect = CGRectMake (limit, 50, 320, 302);
    [self scrollRectToVisible:scrollRect animated:YES];
}
int threshold = 0;

- (void) setSize:(int)_pages {
	pages = _pages;
	int sizeOfcontent = (_pages+1) * 320;//+1
	self.contentSize = CGSizeMake(sizeOfcontent, 305);
	threshold = pages>1?(pages-1)*320+refreshAsset:320+refreshAsset;

	int limit = pages * 320;
	CGRect scrollRect = CGRectMake (limit, 50, 320, 302);
    [self scrollRectToVisible:scrollRect animated:YES];
}

- (void) flushEvents {
	NSLog(@"flush events");
	UIView *profile = [contentPages objectAtIndex:0];

	for (int idx = 0; idx < [contentPages count]; idx++) {
		UIView *pageToFlush = [contentPages objectAtIndex:idx];
		[pageToFlush removeFromSuperview];
		
	}
	pages = 0;
	[contentPages removeAllObjects];
	[self addEvent:profile];
	[self setSize:pages];
}
- (void) scrollAtPercentage:(float)_percentage {
	
}

- (void) addEvents:(NSArray*) _events {
	
	int idz = 0;
	pages += [_events count];
	for (int idx = [_events count]; idx > 0; --idx) {
		[contentPages addObject:[_events objectAtIndex:idz]];
		UIView *page = [contentPages objectAtIndex:idz];
		CGRect pageRect = page.frame;
		page.frame = CGRectMake(320*(idx+1), pageRect.origin.y, pageRect.size.width, pageRect.size.height);
		[self addSubview:page];
		idz++;
	}

	[self setSize:pages];
}
- (void) addEvent:(UIView*) _event {
	
	[contentPages addObject: _event];
	int pageWide = 320;
	pages += [contentPages count];
	int idz=0;

	for (int idx = pages; idx > 0; --idx) {
		UIView *page = [contentPages objectAtIndex:idz];
		CGRect pageRect = page.frame;
		page.frame = CGRectMake(320*idx, pageRect.origin.y, pageRect.size.width, pageRect.size.height);
		idz++;
	}
	
	[self addSubview:_event];
	[self setSize:pages];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - Scrolling Stuff
bool scrolling = NO;
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)_scrollView {
	
}
BOOL timerExist = NO;
bool blockRefreshing = NO;
NSTimer *timer = nil;

- (void) refreshTimer:(NSTimer*)_timer {
	self.contentOffset = CGPointMake((pages)*320, 0);
	NSLog(@"offset: %f", self.contentOffset);
	blockRefreshing = NO;
	timer = nil;
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	
	static int refThreshold = -1;

	//NSLog(@"%f", scrollView.contentOffset.x);
	
	if ( scrollView.contentOffset.x > threshold) { //2910
		NSLog(@" ** LOADING EVENTS **");
		//[userContentRef refresh];
		refThreshold = threshold;
		scrolling = YES;
		blockRefreshing = YES;
	}
	if (blockRefreshing) {
		self.contentOffset = CGPointMake(refThreshold, 0);
		if (nil == timer) {
			timer = [NSTimer scheduledTimerWithTimeInterval:1.0
												 target:self
											   selector:@selector(refreshTimer:)
											   userInfo:nil
												repeats:NO];
		}
	}
	//int page = scrollView.contentOffset.x * 0.003 + 0;
	//NSLog(@"scroll: %f, page: %d", scrollView.contentOffset.x, page);
	//[waveLine setMarkerAtPage:page];
}

/*
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	
	static int refThreshold = -1;
	static NSTimer *timer;
	//NSLog(@"%f", scrollView.contentOffset.x);

	if (( scrollView.contentOffset.x > threshold) && (!loading)) { //2910
		if (!loading) {
			NSLog(@" ** LOADING EVENTS **");
			//[userContentRef refresh];
			refThreshold = threshold;
			scrolling = YES;
		}
	} 
	if (loading) {
		
		if (scrolling) {
			if (!timerExist) {
				timer = [NSTimer scheduledTimerWithTimeInterval:1.0
															  target:self
															selector:@selector(refreshTimer:)
															userInfo:nil
															 repeats:NO];
				timerExist = YES;
			}
			self.contentOffset = CGPointMake(refThreshold, 0);
		}
	}
	//int page = scrollView.contentOffset.x * 0.003 + 0;
	//NSLog(@"scroll: %f, page: %d", scrollView.contentOffset.x, page);
	//[waveLine setMarkerAtPage:page];
}
*/
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
	
	NSLog(@"finish");
	scrolling = NO;
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	
	//[waveLine setMarkerAtPage:scrollView.contentOffset.x/480];
}


#pragma mark -

@end
