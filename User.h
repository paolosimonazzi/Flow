//
//  User.h
//  Flow
//
//  Created by Paolo Simonazzi on 3/12/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
	
}

@property (nonatomic, retain) NSString	*userName;
@property (nonatomic, retain) NSString	*facebookID;
@property (nonatomic, assign) int		ID;

@property (nonatomic, retain) NSString *use;

+ (User*) getUser;

@end
