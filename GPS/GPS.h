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

@interface GPS : NSObject <CLLocationManagerDelegate> {

	CLLocationManager* gpsManager;
}

@end
