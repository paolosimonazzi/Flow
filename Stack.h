//
//  Stack.h
//  Flow
//
//  Created by Paolo Simonazzi on 4/8/13.
//  Copyright (c) 2013 Paolo Simonazzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject {
    NSMutableArray *contents;
}

- (void)push:(id)object;
- (id)pop;


@end
