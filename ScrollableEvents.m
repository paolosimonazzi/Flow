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

- (void) setSize:(int)_pages {
	pages = _pages;
	int sizeOfcontent = (_pages) * 320;//+1
	self.contentSize = CGSizeMake(sizeOfcontent, 305);
}

- (void) flushEvents {
	NSLog(@"flush events");
	for (int idx = 1; idx<[contentPages count]; idx++) {
		UIView *pageToFlush = [contentPages objectAtIndex:idx];
		[pageToFlush removeFromSuperview];
	}
	UIView *profile = [contentPages objectAtIndex:0];
	[contentPages removeAllObjects];
	[contentPages addObject:profile];
	pages = 1;
	//[self setSize:1];
}

- (void) addEvents:(NSArray*) _events {
	
	int idz=0;
	
	for (int idx = [_events count]; idx > 0; --idx) {
		[contentPages addObject:[_events objectAtIndex:idz]];
		UIView *page = [contentPages objectAtIndex:idz];
		CGRect pageRect = page.frame;
		page.frame = CGRectMake(320*idx, pageRect.origin.y, pageRect.size.width, pageRect.size.height);
		[self addSubview:page];
		idz++;
		pages++;
	}

	//self.contentOffset = CGPointMake(320*pages, 0);
	self.contentOffset = CGPointMake((pages-1)*320, 0);
	[self setSize:pages];

}
- (void) addEvent:(UIView*) event {
	
	[contentPages addObject:event];
	int pageWide = 320;

	pages++;

	int idz=0;
	for (int idx = pages; idx > 0; --idx) {
		
		UIView *page = [contentPages objectAtIndex:idz];
		CGRect pageRect = page.frame;
		page.frame = CGRectMake(320*idx, pageRect.origin.y, pageRect.size.width, pageRect.size.height);
		self.contentOffset = CGPointMake(320*idz, 0);
		idz++;
	}
	[self setSize:pages];
	[self addSubview:event];
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
- (void) refreshTimer:(NSTimer*)_timer {
	if (pages>1) {
		self.contentOffset = CGPointMake((pages-1)*320, 0);
	} else {
		//self.contentOffset = CGPointMake(640, 0);
	}
	NSLog(@"offset: %f", self.contentOffset);
	timerExist = NO;
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	
	static int refThreshold = -1;
	static NSTimer *timer;
	//NSLog(@"%f", scrollView.contentOffset.x);

	if (!pages) {
		NSLog(@"pages=0");
	}
	int threshold = pages>1?(pages-1)*320+refreshAsset:320;
	if (( scrollView.contentOffset.x > threshold) && (!loading)) { //2910
		if (!loading) {
			NSLog(@" ** LOADING EVENTS **");
			//[userContentRef getEvents:[User getUser].ID];
			[userContentRef refresh];
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
			//scrolling = NO;
		}
	}
	//int page = scrollView.contentOffset.x * 0.003 + 0;
	//NSLog(@"scroll: %f, page: %d", scrollView.contentOffset.x, page);
	//[waveLine setMarkerAtPage:page];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
	
	NSLog(@"finish");
	scrolling = NO;
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	
	//[waveLine setMarkerAtPage:scrollView.contentOffset.x/480];
}


#pragma mark -

@end
