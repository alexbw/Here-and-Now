//
//  FirstViewController.h
//  Here and Now
//
//  Created by Alex Wiltschko on 5/13/12.
//  Copyright (c) 2012 Datta Lab, Harvard University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h> 
#import "HANFeature.h"
#import "HANAnnotationView.h"

@interface FirstViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;

@end
