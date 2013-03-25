//
//  Conncection.m
//  Flow
//
//  Created by Paolo Simonazzi on 2/26/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "Connection.h"
#import "User.h"

@implementation Connection

@synthesize myDelegate;

- (id) initWithTarget:(id)_target withSelector:(SEL) _sel {
	
	self = [super init];
	
	self->target = _target;
	self->callBack = _sel;
	
	return self;
}

#pragma mark - Connection response

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
	
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
	
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
	NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
	int code = [httpResponse statusCode];
	NSLog(@"status: %d", code);
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

    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);

	if ([receivedData length]>0) {

		[self->target performSelector:self->callBack withObject:receivedData];
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
- (void) tracePosition:(NSMutableDictionary*) data {

	NSError* error;
	User *user = [User getUser];
	
	[data setObject:@"POSITION_TRACE" forKey:@"@class"];
	//[data setObject:@"65536" forKey:@"userId"];
	[data setObject:[NSString stringWithFormat:@"%d", user.ID] forKey:@"userId"];

	NSLog(@"dictionary: %@", [data description]);

	NSData* jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];

	NSString *strJson = [NSString stringWithUTF8String:[jsonData bytes]];

	NSLog (@"json str:%@", strJson);

	
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

- (void) getEvents:(NSDate*)start stop:(NSDate*) stop {
	
	NSString *start_str = [NSString stringWithFormat:@"%d000", (int)[start timeIntervalSince1970]];
	
	NSString *stop_str = [NSString stringWithFormat:@"%d000", (int)[stop timeIntervalSince1970]];
	
	NSString *urlRequest_str = [NSString stringWithFormat:@"http://glance-server.herokuapp.com/services/event/user-%lu/%@to%@",[User getUser].ID, start_str, stop_str];
	
	NSLog(@"events request: %@", urlRequest_str);
	
	//@"http://glance-server.herokuapp.com/services/event/user-65536/1361880000000to1361880087160"]
	
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
	
	NSLog(@"image loading");
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_str] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	
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

- (void) friendshipRequest:(unsigned long) userId {
	
	NSString *urlRequest_str = [NSString stringWithFormat:@"http://glance-server.herokuapp.com/services/user/%lu/friendship/request-%lu", [User getUser].ID, userId];
	NSLog(@"friendShip -> %@", urlRequest_str);
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlRequest_str]  cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
	
	[theRequest setHTTPMethod:@"PUT"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	//[theRequest setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
	//[theRequest setHTTPBody: jsonData];
	
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
