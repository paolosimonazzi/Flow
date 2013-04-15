//
//  ScrollableEvents.m
//  Flow
//
//  Created by Paolo Simonazzi on 4/12/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "ScrollableEvents.h"

@implementation ScrollableEvents

@synthesize loading;

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
	}
	
	return self;
}

- (void) scrollAtPage:(int) page {
	int limit = (pages - page-1) * 320;
    CGRect scrollRect = CGRectMake (limit, 50, 320, 302);
    [self scrollRectToVisible:scrollRect animated:YES];
}

- (void) setSize:(int)_pages {
	pages = _pages;
	int sizeOfcontent = (_pages+1) * 320;
	self.contentSize = CGSizeMake(sizeOfcontent, 305);
}

- (void) flushEvents {
	NSLog(@"flush events");
	for (int idx = 0; idx<[contentPages count]; idx++) {
		UIView *pageToFlush = [contentPages objectAtIndex:idx];
		[pageToFlush removeFromSuperview];
	}
	[contentPages removeAllObjects];
	pages = 0;
}

- (void) addEvent:(UIView*) event {
	
	[contentPages addObject:event];
	int pageWide = 320;
	
	int idz=0;
	
	for (int idx = pages; idx > 0; --idx) {
		
		UIView *page = [contentPages objectAtIndex:idz];
		CGRect pageRect = page.frame;
		page.frame = CGRectMake(/*pageRect.origin.x+*/320*idx, pageRect.origin.y, pageRect.size.width, pageRect.size.height);
		pageRect = page.frame;		
		idz++;
	}
	//page.frame = CGRectMake(pageRect.origin.x+320*idz, pageRect.origin.y, pageRect.size.width, pageRect.size.height);

	[self addSubview:event];

	[self setSize:pages];
	pages++;
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

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)_scrollView {
	
}


- (void) refreshTimer:(NSTimer*)_timer {
	loading = NO;
	//scrollView.contentOffset = CGPointMake(2880, 0);
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
	
	NSLog(@"%f", scrollView.contentOffset.x);
	if ( scrollView.contentOffset.x > 380) { //2910
		
		if (!loading) {
			//[self getEvents];
		}
	}
	if (loading) {
		//scrollView.contentOffset = CGPointMake((numberOfEvents-1)*320, 0);
		NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5
														  target:self
														selector:@selector(refreshTimer:)
														userInfo:nil
														 repeats:NO];
		//[refreshActivityIndicator startAnimating];
	}
	int page = scrollView.contentOffset.x*0.003 + 0;
	//NSLog(@"scroll: %f, page: %d", scrollView.contentOffset.x, page);
	//[waveLine setMarkerAtPage:page];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
	
	NSLog(@"finish");
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	
	//[waveLine setMarkerAtPage:scrollView.contentOffset.x/480];
}


#pragma mark -

@end
