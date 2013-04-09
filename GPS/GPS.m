//
//  GPS.m
//  Flow
//
//  Created by Paolo Simonazzi on 2/22/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "GPS.h"
#import "Stack.h"


@implementation GPS

NSMutableDictionary *lastGpsInfo;

//- (void) fire;
@synthesize connectionsStack;

- (id) init {
	gpsManager = [[CLLocationManager alloc] init];
	gpsManager.delegate = self;
	NSLog(@"gps allocated");
	[gpsManager startUpdatingLocation];
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60
													  target:self
													selector:@selector(fire)
													userInfo:nil
													 repeats:YES];
	
	connectionsStack = [[Stack alloc] init];
	
	return [super init];
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"GPS_error");
}

- (void) fire {
	
	int numCalls=0;
	CLLocationDegrees lat_avg = 0, lon_avg = 0;
	CLLocationSpeed speed_avg = 0;

	// time stuff

	unsigned long timeMs;
	
	for (CLLocation* gpsInfo = [connectionsStack pop]; nil!=gpsInfo; gpsInfo = [connectionsStack pop], numCalls++) {

		lat_avg += gpsInfo.coordinate.latitude;
		lon_avg += gpsInfo.coordinate.longitude;
		speed_avg += gpsInfo.speed;
		timeMs = [gpsInfo.timestamp timeIntervalSince1970];
		
	}
	if (!numCalls)
		return;
	
	lat_avg /= numCalls;
	lon_avg /= numCalls;
	speed_avg /= numCalls;
	
	NSLog(@"calls fired: %d", numCalls);
	
	NSString *lat_str = [NSString stringWithFormat:@"%0.06f", lat_avg];
	NSString *lng_str = [NSString stringWithFormat:@"%0.06f", lon_avg];
	
	NSDictionary *position = [NSDictionary dictionaryWithObjectsAndKeys:lat_str, @"lat", lng_str, @"lng", nil];
	
	NSString *speed = [NSString stringWithFormat:@"%f", speed_avg];
	NSString *time = [NSString stringWithFormat:@"%lu000", timeMs];
	
	NSMutableDictionary* gpsInfo_dict = [NSMutableDictionary dictionaryWithObjectsAndKeys: position, @"position",
									speed, @"speed",
									time, @"time",
									nil];
	
	lastGpsInfo = gpsInfo_dict;

	Connection *conn = [[Connection alloc] initWithTarget:self withSelector:@selector(callResponse:)];
	
	[conn tracePosition:gpsInfo_dict];

}

+ (NSMutableDictionary*) getLastGpsPosition {
	if (nil==lastGpsInfo) {
		NSDictionary *position = [NSDictionary dictionaryWithObjectsAndKeys:@"-", @"lat", @"-", @"lng", nil];
		lastGpsInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys: position, @"position",
											 @"0", @"speed",
											 @"0", @"time",
											 nil];
	}
	return lastGpsInfo;
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
	
	NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
	
	[formatter setTimeStyle:kCFDateFormatterFullStyle];//NSDateFormatterMediumStyle];
	
	unsigned long timeMs = [newLocation.timestamp timeIntervalSince1970];

	
	NSString *gpsStr = [NSString stringWithFormat:@"(%@) %@ Location %.06f %.06f %@", ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) ? @"bg" : @"fg",  @"gps:", newLocation.coordinate.latitude, newLocation.coordinate.longitude, [formatter stringFromDate:newLocation.timestamp]];
	
	NSLog(@"log: %@", gpsStr);

	[connectionsStack push:newLocation];
}

#pragma mark - connection

- (void) callResponse:(NSData*)_data {
	//NSLog(@"Succeeded! Received bytes of data (gps)");
	
}

@end
