//
//  Stack.m
//  Flow
//
//  Created by Paolo Simonazzi on 4/8/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import "Stack.h"

@implementation Stack
// superclass overrides

- (id)init {
    if (self = [super init]) {
        contents = [[NSMutableArray alloc] init];
    }
    return self;
}
/*
- (void)dealloc {
    [contents release];
    [super dealloc];
}
*/
// Stack methods

- (void)push:(id)object {
    [contents addObject:object];
}

- (id)pop {
    NSUInteger count = [contents count];
    if (count > 0) {
        id returnObject = [contents objectAtIndex:count - 1];
        [contents removeLastObject];
        return returnObject;
    }
    else {
        return nil;
    }
}

@end
