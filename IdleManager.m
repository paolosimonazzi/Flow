//
//  IdleManager.m
//  Flow
//
//  Created by Paolo Simonazzi on 4/5/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "IdleManager.h"
#import "Connection.h"

@implementation IdleManager
@synthesize accelerometer, motionManager;

- (void) tick {
	static UIDeviceOrientation orientation = UIDeviceOrientationUnknown;
	static UIInterfaceOrientation orientation2 = UIDeviceOrientationPortrait;
	NSRunLoop* myRunLoop = [NSRunLoop mainRunLoop];
	//NSLog(@"tick");
    NSInteger    loopCount = 10;
	NSNotification *not;
	NSNotificationQueue *queue = [NSNotificationQueue defaultQueue];
	
	if ([UIDevice currentDevice].orientation != orientation) {
		orientation = [UIDevice currentDevice].orientation;
		NSLog(@"hai spostato il telefono, merda!");
	}

	if ([UIApplication sharedApplication].statusBarOrientation != orientation2) {
		orientation2 = [UIApplication sharedApplication].statusBarOrientation;
		NSLog(@"hai spostato il telefono, merda2!");
	}
	NSNotificationQueue *ntos = [NSNotificationQueue defaultQueue];
	int ff=0;
	 
}
- (void)handleDeviceMotion:(CMDeviceMotion*)motion{
    CMAttitude *attitude = motion.attitude;
	
    float accelerationThreshold = 0.1; // or whatever is appropriate - play around with different values
    CMAcceleration userAcceleration = motion.userAcceleration;
	
    float rotationRateThreshold = .1;
    CMRotationRate rotationRate = motion.rotationRate;
	
    if ((rotationRate.x) > rotationRateThreshold) {
        if (fabs(userAcceleration.x) > accelerationThreshold || fabs(userAcceleration.y) > accelerationThreshold || fabs(userAcceleration.z) > accelerationThreshold) {
			
            //NSLog(@"rotation rate = [Pitch: %f, Roll: %f, Yaw: %f]", attitude.pitch, attitude.roll, attitude.yaw);
            //NSLog(@"motion.rotationRate = %f", rotationRate.x);
			movement = YES;
        }
    } else if ((-rotationRate.x) > rotationRateThreshold) {
        if (fabs(userAcceleration.x) > accelerationThreshold || fabs(userAcceleration.y) > accelerationThreshold || fabs(userAcceleration.z) > accelerationThreshold) {
			
            //NSLog(@"rotation rate = [Pitch: %f, Roll: %f, Yaw: %f]", attitude.pitch, attitude.roll, attitude.yaw);
            //NSLog(@"motion.rotationRate = %f", rotationRate.x);
			movement = YES;
        }
    }
	
	if (movement) {
		
		NSTimeInterval timeElapsed =  [idleTime timeIntervalSinceNow]*-1;

		NSLog(@"idle time: %f", timeElapsed);
		
		movement = NO;
		
		if (timeElapsed>5) {
			
			Connection *conn = [[Connection alloc] initWithTarget:self withSelector:@selector(callResponse:)];
			
			[conn sleepEvent:YES withTime:timeElapsed];
			
		}
		
		idleTime = [NSDate dateWithTimeIntervalSinceNow:0];
		
	}
}
- (void)startMotionManager {
	if (motionManager == nil) {
		motionManager = [[CMMotionManager alloc] init];
	}
	
	motionManager.deviceMotionUpdateInterval = 1/25.0;
	if (motionManager.deviceMotionAvailable) {
		
		NSLog(@"Device Motion Available");
		[motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
										   withHandler: ^(CMDeviceMotion *motion, NSError *error){
											   //CMAttitude *attitude = motion.attitude;
											   //NSLog(@"rotation rate = [%f, %f, %f]", attitude.pitch, attitude.roll, attitude.yaw);
											   [self performSelectorOnMainThread:@selector(handleDeviceMotion:) withObject:motion waitUntilDone:YES];
										   }];
		//[motionManager startDeviceMotionUpdates];
	} else {
		NSLog(@"No device motion on device.");
		[self setMotionManager:nil];
	}
}
- (void) initStartOrientationManager {
	//[self performSelectorOnMainThread:@selector(deviceOrientationChanged:) withObject:self waitUntilDone:YES];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationChanged:)
												 name:UIDeviceOrientationDidChangeNotification object:nil];

}

- (id) init {
	if ((self = [super init]))
	{
		// register for device orientation change events
		//[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
		//[self performSelectorOnMainThread:@selector(initStartOrientationManager) withObject:nil waitUntilDone:YES];
		//[self initStartOrientationManager];
		NSLog(@"idleManager initialised");
		
		NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5
														  target:self
														selector:@selector(tick)
														userInfo:nil
														 repeats:YES];
		
		//
		[self startMotionManager];
		idleTime = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
	}
	return self;
}
-(void) deviceOrientationChanged:(NSNotification*)notification {

	NSNotification *not = notification;
	NSLog(@"orientation changed");
	//NSNotificationQueue *ntos = [NSNotificationQueue defaultQueue];
	//[ntos dequeueNotificationsMatching:notification coalesceMask: NSNotificationNoCoalescing];

	int app=0;

}
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	NSLog(@"%@", [NSString stringWithFormat:@"%@%f", @"X: ", acceleration.x]);
	NSLog(@"%@", [NSString stringWithFormat:@"%@%f", @"Y: ", acceleration.y]);
	NSLog(@"%@",  [NSString stringWithFormat:@"%@%f", @"Z: ", acceleration.z]);
	
}

@end

/*
 do
 {
 // Run the run loop 10 times to let the timer fire.
 [myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
 loopCount--;
 }
 while (loopCount);
 */
/*
 do {
 
 [[NSRunLoop mainRunLoop] runUntilDate:[NSDate date]];
 
 } while ([UIDevice currentDevice].orientation == orientation);
 */

//[[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];

