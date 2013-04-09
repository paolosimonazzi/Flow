//
//  GPS.h
//  Flow
//
//  Created by Paolo Simonazzi on 2/22/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Connection.h"
@class Stack;

@interface GPS : NSObject <CLLocationManagerDelegate> {

	CLLocationManager* gpsManager;
	
}
@property (nonatomic, retain) Stack *connectionsStack;

+ (NSMutableDictionary*) getLastGpsPosition;

@end
