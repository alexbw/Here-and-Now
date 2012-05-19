//
//  HANManager.m
//  Here and Now
//
//  Created by Alex Wiltschko on 5/19/12.
//  Copyright (c) 2012 Datta Lab, Harvard University. All rights reserved.
//

#import "HANManager.h"

HANManager *sharedManager = nil;

@implementation HANManager


#pragma mark - Singleton Methods
+ (HANManager *)sharedManager
{
	@synchronized(self)
	{
		if (sharedManager == nil) {
			sharedManager = [[HANManager alloc] init];
		}
	}
    return sharedManager;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedManager == nil) {
            sharedManager = [super allocWithZone:zone];
            return sharedManager;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)init
{
	if (self = [super init])
	{
		
    }
    
    return self;
}

@end
