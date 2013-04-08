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

}
-(void) deviceOrientationChanged:(NSNotification*)notification;
@property (nonatomic, retain) UIAccelerometer *accelerometer;
@property (nonatomic, retain) CMMotionManager *motionManager;

@end
