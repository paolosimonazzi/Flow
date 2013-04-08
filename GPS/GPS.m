//
//  GPS.m
//  Flow
//
//  Created by Paolo Simonazzi on 2/22/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "GPS.h"

@implementation GPS

- (id) init {
	gpsManager = [[CLLocationManager alloc] init];
	gpsManager.delegate = self;
	NSLog(@"gps allocated");
	[gpsManager startUpdatingLocation];
	return [super init];
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"GPS_error");
}


- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
	
	NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
	
	[formatter setTimeStyle:kCFDateFormatterFullStyle];//NSDateFormatterMediumStyle];
	
	unsigned long timeMs = [newLocation.timestamp timeIntervalSince1970];

	
	NSString *gpsStr = [NSString stringWithFormat:@"(%@) %@ Location %.06f %.06f %@", ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) ? @"bg" : @"fg",  @"gps:", newLocation.coordinate.latitude, newLocation.coordinate.longitude, [formatter stringFromDate:newLocation.timestamp]];
	
	//NSLog(@"log: %@", gpsStr);
	
	// ** structure creation **
	NSString *lat = [NSString stringWithFormat:@"%0.06f", newLocation.coordinate.latitude];
	NSString *lng = [NSString stringWithFormat:@"%0.06f", newLocation.coordinate.longitude];

	NSDictionary *position = [NSDictionary dictionaryWithObjectsAndKeys:lat, @"lat", lng, @"lng", nil];
	
	NSString *speed = [NSString stringWithFormat:@"%f", newLocation.speed];
	NSString *time = [NSString stringWithFormat:@"%lu000", timeMs];
	
	NSMutableDictionary* gpsInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys: position, @"position",
								 speed, @"speed",
								 time, @"time",
								 nil];

	//Connection *conn = [[Connection alloc] initWithTarget:self withSelector:@selector(callResponse:)];
	
	//[conn tracePosition:gpsInfo];
	
}

#pragma mark - connection

- (void) callResponse:(NSData*)_data {
	//NSLog(@"Succeeded! Received bytes of data (gps)");
	
}

@end
