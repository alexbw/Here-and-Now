//
//  HANAnnotationView.m
//  Here and Now
//
//  Created by Alex Wiltschko on 5/16/12.
//  Copyright (c) 2012 Datta Lab, Harvard University. All rights reserved.
//

#import "HANAnnotationView.h"

@implementation HANAnnotationView
@synthesize feature;

- (id)initWithFeature:(HANFeature *)aFeature;
{
    self = [super init];
    if (self)
    {
        feature = aFeature;
    }
    
    return [self initWithAnnotation:self reuseIdentifier:@"HANAnnotationView"];
}



@end
