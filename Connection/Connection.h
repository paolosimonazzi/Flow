//
//  Conncection.h
//  Flow
//
//  Created by Paolo Simonazzi on 2/26/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TRACE 0
#define EVENTS 1


@interface Connection : NSObject <NSURLConnectionDelegate> {

	NSMutableData		*receivedData;
	int					type;
	SEL					dataBack;
	SEL					statusBack;
	id					target;
	NSMutableURLRequest *theLastRequest;
}

- (void) loging:(NSString*)_facebookId withToken:(NSString*)_token;


- (void) tracePosition:		(NSMutableDictionary*) data;

- (void) getEvents:(unsigned long)_user start:(NSDate*)_start stop:(NSDate*)_stop;

- (void) loadImage:			(NSString*)_str;
- (void) loadUsersNetwork;

- (void) friendshipRequest:	(unsigned long) userId;
- (void) friendshipNomore:  (unsigned long) userId;
- (void) friendshipAccept:	(unsigned long) userId;
- (void) friendshipDecline:	(unsigned long) userId;
- (void) retryBitch;

//- (void) sleepEvent:		(BOOL) _begin withTime:(NSTimeInterval) _time;

- (void) sleepEventWithBegin:(NSDate*)_start stop:(NSDate*)_stop;


- (void) loadGlance;

- (id)   initWithTarget:		(id)_target withSelector:(SEL) _sel;
- (void) setCallBackForStatus:		(SEL)_sel;

@property (nonatomic, retain) id	myDelegate;
@property (nonatomic, assign) int	retry;
@end
