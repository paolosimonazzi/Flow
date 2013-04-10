//
//  IdleManager.h
//  Flow
//
//  Created by Paolo Simonazzi on 4/5/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface IdleManager : NSObject {
	NSDate *idleTime;
	BOOL	movement;
	BOOL	active;
}
- (void) deviceOrientationChanged:(NSNotification*)notification;
- (void) enable;
- (void) disable;
@property (nonatomic, retain) UIAccelerometer *accelerometer;
@property (nonatomic, retain) CMMotionManager *motionManager;

@end
