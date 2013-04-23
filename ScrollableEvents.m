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
	int sizeOfcontent = (_pages + 1) * 320;//+1
	self.contentSize = CGSizeMake(sizeOfcontent, 305);
	//threshold = pages>1?(pages)*320+refreshAsset:320+refreshAsset;
	threshold = (pages)*320 + refreshAsset; //-1
	int limit = (pages) * 320; //-1
	CGRect scrollRect = CGRectMake (limit, 0, 320, 302);// 0->50
    [self scrollRectToVisible:scrollRect animated:NO];
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
	int pageTo = _percentage*pages;
	//NSLog(@"page at: %d", pageTo);
	[self scrollAtPage:pageTo];
}

- (void) addEvents:(NSArray*) _events {
	
	int idz = 0;
	pages += [_events count];
	int eventsSize = [_events count];
	for (int idx=0; idx<[_events count];++idx) {
		[contentPages addObject:[_events objectAtIndex: eventsSize - idx - 1]];
	}
	
	for (int idx = pages-1; idx >= 0; --idx) {
		UIView *page = [contentPages objectAtIndex:idz];
		CGRect pageRect = page.frame;
		page.frame = CGRectMake(320*(idx+1), pageRect.origin.y, pageRect.size.width, pageRect.size.height); //+1
		[self addSubview:page];
		idz++;
	}
	
	[self setSize:pages];
	//NSLog(@"total pages: %d", pages);
}
- (void) addEvent:(UIView*) _event {
	
	[contentPages addObject: _event];
	int pageWide = 320;
	pages += [contentPages count];
	int idz=0;

	for (int idx = pages; idx > 0; --idx) {
		UIView *page = [contentPages objectAtIndex:idz];
		CGRect pageRect = page.frame;
		page.frame = CGRectMake(320*(idx+1), pageRect.origin.y, pageRect.size.width, pageRect.size.height);
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
BOOL timerExist = NO, dragging = NO;
bool blockRefreshing = NO;
NSTimer *timer = nil;


- (void) bounceCall:(NSTimer*)_timer {
	self.bounces = YES;
}
 
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	
	static int refThreshold = -1;
	static int fuckingCounter = 0;
	static int fuckingCounter2 = 0;
	//NSLog(@"%f", scrollView.contentOffset.x);
	if (!dragging) {
		return;
	}
	if ( scrollView.contentOffset.x > threshold) { //2910
		refThreshold = threshold;
		blockRefreshing = YES;
		self.bounces = YES;
	}
	if (blockRefreshing) {
		self.contentOffset = CGPointMake(refThreshold, 0);
		fuckingCounter++;
		fuckingCounter2 = 1;
		
		if (fuckingCounter > 40) {
			blockRefreshing = NO;
			
			NSLog(@" ** LOADING EVENTS **");
			[userContentRef refresh];
			fuckingCounter = 0;
			self.bounces = NO;
			timer = [NSTimer scheduledTimerWithTimeInterval:2//60
											   target:self
												   selector:@selector(bounceCall:)
									
												   userInfo:nil
											  repeats:NO];
		}
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	dragging = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	
	//[waveLine setMarkerAtPage:scrollView.contentOffset.x/480];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	dragging = NO;
	float absPos = (scrollView.contentOffset.x/320)/pages;
	//NSLog(@"absPos: %f", absPos);
	[userContentRef moveTheMarker:absPos];
	
}



#pragma mark -

@end
