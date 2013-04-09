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

	NSMutableData *receivedData;
	int type;
	SEL callBack;
	id  target;

}
- (void) loging:(NSString*)_facebookId withToken:(NSString*)_token;


- (void) tracePosition:		(NSMutableDictionary*) data;
- (void) getEvents:			(NSDate*)start stop:(NSDate*) stop;
- (void) loadImage:			(NSString*)_str;
- (void) loadUsersNetwork;

- (void) friendshipRequest:	(unsigned long) userId;
- (void) friendshipNomore:  (unsigned long) userId;
- (void) friendshipAccept:	(unsigned long) userId;
- (void) friendshipDecline:	(unsigned long) userId;

- (void) sleepEvent:		(BOOL) _begin withTime:(NSTimeInterval) _time;



- (void) loadGlance;

- (id)   initWithTarget:	(id)_target withSelector:(SEL) _sel;

@property (nonatomic, retain) id   myDelegate;

@end
