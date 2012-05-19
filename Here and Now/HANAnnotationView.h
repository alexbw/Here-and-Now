//
//  HANAnnotationView.h
//  Here and Now
//
//  Created by Alex Wiltschko on 5/16/12.
//  Copyright (c) 2012 Datta Lab, Harvard University. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "HANFeature.h"

@interface HANAnnotationView : MKPinAnnotationView

@property HANFeature *feature;

- (id)initWithFeature:(HANFeature *)aFeature;

@end
