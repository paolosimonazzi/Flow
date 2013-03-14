//
//  User.m
//  Flow
//
//  Created by Paolo Simonazzi on 3/12/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "User.h"

@implementation User

static User *singleTon = nil;

@synthesize userName, facebookID, ID;


+ (User*) getUser {
	@synchronized (self) {
		if (nil == singleTon) {
			singleTon = [[User alloc] init];
			singleTon.ID = 65536;
		}
	}
	return singleTon;
}
@end
