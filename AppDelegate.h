//
//  AppDelegate.h
//  Flow
//
//  Created by Paolo Simonazzi on 2/21/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@class ViewController, IdleManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow			*window;

@property (strong, nonatomic) UIViewController	*viewController;

@property (nonatomic, retain) IdleManager		*idleManager;

//@property (strong, nonatomic) FBSession *session;

@end
