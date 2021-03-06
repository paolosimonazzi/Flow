//
//  Conncection.m
//  Flow
//
//  Created by Paolo Simonazzi on 2/26/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "Connection.h"
#import "User.h"
#import "GPS.h"

@implementation Connection

@synthesize myDelegate, retry;

- (id) initWithTarget:(id)_target withSelector:(SEL) _sel {
	
	self = [super init];
	
	self->target = _target;
	self->dataBack = _sel;
	self->statusBack = nil;
	retry = 0;
	return self;
}

-(void) setCallBackForStatus:(SEL)_sel {
	self->statusBack = _sel;
}

- (void) retryCall:(NSTimer*) _timer {

	NSURLConnection *theConnection  = [[NSURLConnection alloc] initWithRequest:theLastRequest delegate:self];
	if (theConnection) {
		receivedData = [NSMutableData data];
	}
	NSLog(@"connection failed->retry:%d", retry);
	NSLog(@"dictionary sleep (retry): %@", [theLastRequest description]);
	retry--;
}

#pragma mark - Connection response
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
	
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
	NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
	int code = [httpResponse statusCode];
	
	//NSLog(@"http response:%d", code);
	
	if ( (code != 201 ) && (code != 200) ) {
		if (retry) {
			[NSTimer scheduledTimerWithTimeInterval:60
											 target:self
										   selector:@selector(retryCall:)
										   userInfo:nil
											repeats:NO];
		}
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
	//NSLog(@"data");
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// data back
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

    //NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);

	if ([receivedData length]>0) {

		[self->target performSelector:self->dataBack withObject:receivedData];
	}
}

- (void)connection:(NSURLConnection *)connection  didFailWithError:(NSError *)error {

    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}
#pragma mark -

- (NSData*) getData {
	return self->receivedData;
}

- (void) loging:(NSString*)_facebookId withToken:(NSString*)_token {

	NSString *urlRequest_str = [NSString stringWithFormat:@"http://glance-server.herokuapp.com/services/user/facebookLogin?fbId=%@&token=%@", _facebookId, _token];
	
	NSLog(@"login request: %@", urlRequest_str);
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlRequest_str]
															  cachePolicy:NSURLRequestUseProtocolCachePolicy
														  timeoutInterval:60.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		receivedData = [NSMutableData data];
	} else {
	}
}
//- (void) getEvents:(unsigned long)_user start:(NSDate*)_start stop:(NSDate*)_stop {

- (void) sleepEventWithBegin:(NSDate*)_start stop:(NSDate*)_stop {

	NSError* error;

	NSMutableDictionary *sleepData = [NSMutableDictionary dictionaryWithCapacity:0];
	//[data setObject:@"POSITION_TRACE" forKey:@"@class"];
	
	[sleepData setObject:@"SLEEP_TRACE" forKey:@"@class"];
	
	unsigned long begin = [_start timeIntervalSince1970];
	
	[sleepData setObject:[NSString stringWithFormat:@"%lu000", begin] forKey:@"begin"];
	
	unsigned long stop = [_stop timeIntervalSince1970];
	
	[sleepData setObject:[NSString stringWithFormat:@"%lu000", stop] forKey:@"time"];
	
	[sleepData setObject:[NSString stringWithFormat:@"%lu", [User getUser].ID] forKey:@"userId"];
	
	NSData* jsonData = [NSJSONSerialization dataWithJSONObject:sleepData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
	
		
	NSString *strJson = [NSString stringWithUTF8String:[jsonData bytes]];
	
	NSLog(@"sleepJsonData: %@", strJson);
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://glance-server.herokuapp.com/services/trace"]
															  cachePolicy:NSURLRequestUseProtocolCachePolicy
														  timeoutInterval:60.0];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[theRequest setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPBody: jsonData];
	
	theLastRequest = theRequest;
	
	NSURLConnection *theConnection  = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if (theConnection) {
		receivedData = [NSMutableData data];
	} else {
	}

}
/*
- (void) sleepEvent:(BOOL) _begin withTime:(NSTimeInterval) _time {
	
	NSMutableDictionary *data = [GPS getLastGpsPosition];
	
	NSError* error;
	User *user = [User getUser];
	
	[data setObject:@"SLEEP_TRACE" forKey:@"@class"];
	
	[data setObject:[NSString stringWithFormat:@"%ld", user.ID] forKey:@"userId"];
	
	[data setObject:[NSNumber numberWithBool:_begin] forKey:@"begin"];
	
	[data removeObjectForKey:@"position"];
	[data removeObjectForKey:@"time"];
	NSString *timeToSet;
	unsigned long timeMs;
	if (_begin) {
		NSDate *timeIWentToSleep = [NSDate dateWithTimeIntervalSinceNow:-_time]; //-86400
		timeMs = [timeIWentToSleep timeIntervalSince1970];
		
	} else {
		timeMs = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
	}
	
	timeToSet = [NSString stringWithFormat:@"%lu000", timeMs];
	[data setObject:timeToSet forKey:@"time"];

	
	NSLog(@"dictionary sleep: %@", [data description]);
	
	NSData* jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
	
	NSString *strJson = [NSString stringWithUTF8String:[jsonData bytes]];
	
	NSLog (@"json str(sleep):%@", strJson);
	

	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://glance-server.herokuapp.com/services/trace"]
															  cachePolicy:NSURLRequestUseProtocolCachePolicy
														  timeoutInterval:60.0];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[theRequest setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPBody: jsonData];
	
	theLastRequest = theRequest;
	
	NSURLConnection *theConnection  = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if (theConnection) {
		receivedData = [NSMutableData data];
	} else {
	}
}
*/
- (void) retryBitch {
	NSURLConnection *theConnection  = [[NSURLConnection alloc] initWithRequest:theLastRequest delegate:self];
	if (theConnection) {
		receivedData = [NSMutableData data];
	} else {
	}
}


- (void) tracePosition:(NSMutableDictionary*) data {

	NSError* error;
	User *user = [User getUser];
	
	[data setObject:@"POSITION_TRACE" forKey:@"@class"];

	[data setObject:[NSString stringWithFormat:@"%ld", user.ID] forKey:@"userId"];

	//NSLog(@"dictionary position: %@", [data description]);

	NSData* jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];

	NSString *strJson = [NSString stringWithUTF8String:[jsonData bytes]];

	//NSLog (@"json str(trace):%@", strJson);

	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://glance-server.herokuapp.com/services/trace"]
															cachePolicy:NSURLRequestUseProtocolCachePolicy
														timeoutInterval:60.0];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[theRequest setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPBody: jsonData];
	
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if (theConnection) {

		receivedData = [NSMutableData data];
	} else {
	}
}

- (void) getEvents:(unsigned long)_user start:(NSDate*)_start stop:(NSDate*)_stop {
	
	NSString *start_str = [NSString stringWithFormat:@"%d000", (int)[_start timeIntervalSince1970]];
	
	NSString *stop_str = [NSString stringWithFormat:@"%d000", (int)[_stop timeIntervalSince1970]];
	
	NSString *urlRequest_str = [NSString stringWithFormat:@"http://glance-server.herokuapp.com/services/event/user-%lu/eventFeedPage-%@to%@?wl_width=800&wl_height=200", _user, start_str, stop_str];
	
	NSLog(@"events request: %@", urlRequest_str);

	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlRequest_str]
															  cachePolicy:NSURLRequestUseProtocolCachePolicy
															timeoutInterval:60.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		receivedData = [NSMutableData data];
	} else {
	}
}

- (void) loadUsersNetwork {
	
	NSString *urlRequest_str = [NSString stringWithFormat:@"http://glance-server.herokuapp.com/services/user/%d/addFriendsPage", [User getUser].ID ];
	
	NSLog(@"users request: %@", urlRequest_str);
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlRequest_str]
															  cachePolicy:NSURLRequestUseProtocolCachePolicy
														  timeoutInterval:60.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		receivedData = [NSMutableData data];
	} else {
	}
}

- (void) loadImage:(NSString*)_str {
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_str] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:160.0];
	
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		receivedData = [NSMutableData data];
	} else {
	}
}
- (void) loadGlance {
	NSString *urlRequest_str = [NSString stringWithFormat:@"http://glance-server.herokuapp.com/services/user/%lu/glancePage", [User getUser].ID ];
	
	NSLog(@"users request: %@", urlRequest_str);
	
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlRequest_str]
															  cachePolicy:NSURLRequestUseProtocolCachePolicy
														  timeoutInterval:60.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		receivedData = [NSMutableData data];
	} else {
	}
}
- (void) friendshipNomore:(unsigned long) userId {
	NSString *urlRequest_str = [NSString stringWithFormat:@"http://glance-server.herokuapp.com/services/user/%lu/friendship/%lu", [User getUser].ID, userId];
	NSLog(@"friendShip -> %@", urlRequest_str);
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlRequest_str]  cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
	
	[theRequest setHTTPMethod:@"DELETE"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if (theConnection) {
		
		receivedData = [NSMutableData data];
	} else {
	}

}
- (void) friendshipRequest:(unsigned long) userId {
	
	NSString *urlRequest_str = [NSString stringWithFormat:@"http://glance-server.herokuapp.com/services/user/%lu/friendship/request-%lu", [User getUser].ID, userId];
	NSLog(@"friendShip -> %@", urlRequest_str);
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlRequest_str]  cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
	
	[theRequest setHTTPMethod:@"PUT"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if (theConnection) {
		
		receivedData = [NSMutableData data];
	} else {
	}

}

- (void) friendshipAccept:(unsigned long) userId {
	
	NSString *urlRequest_str = [NSString stringWithFormat:@"http://glance-server.herokuapp.com/services/user/%lu/friendship/accept-%lu", [User getUser].ID, userId];
	NSLog(@"friendShip -> %@", urlRequest_str);
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlRequest_str]  cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
	
	[theRequest setHTTPMethod:@"PUT"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if (theConnection) {
		
		receivedData = [NSMutableData data];
	} else {
	}
	
}
- (void) friendshipDecline:(unsigned long) userId {
	
	NSString *urlRequest_str = [NSString stringWithFormat:@"http://glance-server.herokuapp.com/services/user/%lu/friendship/decline-%lu", [User getUser].ID, userId];
	NSLog(@"friendShip -> %@", urlRequest_str);
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlRequest_str]  cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
	
	[theRequest setHTTPMethod:@"PUT"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if (theConnection) {
		
		receivedData = [NSMutableData data];
	} else {
	}
	
}


- (NSArray*)fetchedData:(NSData *)responseData {

    NSError* error;
	NSArray *array = [NSJSONSerialization JSONObjectWithData:responseData //1
													options:kNilOptions
													  error:&error];
	return array;
}

- (void)fetchedData2:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData //1
                                                         options:kNilOptions
                                                           error:&error];
    NSArray* latestLoans = [json objectForKey:@"loans"]; //2
    
    NSLog(@"loans: %@", latestLoans); //3
    NSString *str = [[NSString alloc ]initWithData:responseData encoding:NSUTF8StringEncoding];
	NSLog (@"str back: %@", str);
    // 1) Get the latest loan
    NSDictionary* loan = [latestLoans objectAtIndex:0];
	
    // 2) Get the funded amount and loan amount
    NSNumber* fundedAmount = [loan objectForKey:@"funded_amount"];
    NSNumber* loanAmount = [loan objectForKey:@"loan_amount"];
    float outstandingAmount = [loanAmount floatValue] - [fundedAmount floatValue];
	
}

// 3) Set the label appropriately
/*
 humanReadble.text = [NSString stringWithFormat:@"Latest loan: %@ from %@ needs another $%.2f to pursue their entrepreneural dream",
 [loan objectForKey:@"name"],
 [(NSDictionary*)[loan objectForKey:@"location"] objectForKey:@"country"],
 outstandingAmount
 ];
 
 //build an info object and convert to json
 NSDictionary* info = [NSDictionary dictionaryWithObjectsAndKeys:
 [loan objectForKey:@"name"], @"who",
 [(NSDictionary*)[loan objectForKey:@"location"] objectForKey:@"country"], @"where",
 [NSNumber numberWithFloat: outstandingAmount], @"what",
 nil];
 
 //convert object to data
 NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info
 options:NSJSONWritingPrettyPrinted
 error:&error];
 
 //print out the data contents
 jsonSummary.text = [[NSString alloc] initWithData:jsonData
 encoding:NSUTF8StringEncoding];
 */



@end
