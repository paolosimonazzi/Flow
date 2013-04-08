//
//  AppDelegate.m
//  Flow
//
//  Created by Paolo Simonazzi on 2/21/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "AppDelegate.h"

#import "UserContent.h"
#import <FacebookSDK/FacebookSDK.h>
#import "IdleManager.h"

@implementation AppDelegate

//@synthesize session;
@synthesize idleManager;

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBSession.activeSession handleOpenURL:url];
}

-(void) deviceOrientationChanged:(NSNotification*)notification {
	
	NSNotification *not = notification;
	NSLog(@"orientation changed");
	NSNotificationQueue *ntos = [NSNotificationQueue defaultQueue];
	int app=0;
	//NSRunLoop
	//[[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[FBProfilePictureView class];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	self.viewController = [[UserContent alloc] initWithNibName:@"UserContent" bundle:nil];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
	
	idleManager = [[IdleManager alloc] init];
	/*
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationChanged:)
												 name:UIDeviceOrientationDidChangeNotification object:nil];
*/
    return YES;
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // FBSample logic
    // if the app is going away, we close the session object
    [FBSession.activeSession close];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	NSNotificationQueue *ntos = [NSNotificationQueue defaultQueue];
	int app=0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application	{
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBSession.activeSession handleDidBecomeActive];

}



@end
