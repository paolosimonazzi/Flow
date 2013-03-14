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

- (void) tracePosition:(NSMutableDictionary*) data;
- (void) getEvents:(NSDate*)start stop:(NSDate*) stop;
- (void) loadImage:(NSString*)_str;
- (void) loadUsersNetwork;


- (id) initWithTarget:(id)_target withSelector:(SEL) _sel;

@property (nonatomic, retain) id   myDelegate;

@end
