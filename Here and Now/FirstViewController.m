//
//  FirstViewController.m
//  Here and Now
//
//  Created by Alex Wiltschko on 5/13/12.
//  Copyright (c) 2012 Datta Lab, Harvard University. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize map;


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *url = @"http://demo.openblockproject.org/api/dev1/items.json?locationid=zipcodes/02115";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:
                                 [url stringByAddingPercentEscapesUsingEncoding:
                                  NSUTF8StringEncoding]]];    
    
    [NSURLConnection sendAsynchronousRequest:request 
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               NSMutableDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                               
                               NSArray *features = [parsedData objectForKey:@"features"];
                               

                               NSMutableArray *pinArray = [[NSMutableArray alloc] initWithCapacity:[features count]];
                               

                               float minLat = INFINITY;
                               float minLong = INFINITY;
                               float maxLat = -INFINITY;
                               float maxLong = -INFINITY;
                               
                               for (NSDictionary *feature in features) {
                                   NSArray *coords = [[feature objectForKey:@"geometry"] objectForKey:@"coordinates"];
                                   NSLog(@"F: %@", feature);
                                   NSString *title = [[feature objectForKey:@"properties"] objectForKey:@"title"];
                                   
                                   float longitude = [[coords objectAtIndex:0] floatValue];
                                   float latitude = [[coords objectAtIndex:1] floatValue];

                                   minLong = MIN(minLong, longitude);
                                   maxLong = MAX(maxLong, longitude);
                                   minLat = MIN(minLat, latitude);
                                   maxLat = MAX(maxLat, latitude);
                                   
                                   
                                   MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
                                   point.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
                                   point.title = title;
                                   [pinArray addObject:point];
                                   
                                   NSLog(@"Lat: %f, %f", latitude, longitude);
                                   
                               }
                               
                               float latSpan = (maxLat - minLat)*1.01;
                               float longSpan = (maxLong - minLong)*1.01;
                               float centerLat = (maxLat + minLat) / 2.0;
                               float centerLong = (minLong + maxLong) / 2.0;
                               
                               NSLog(@"Lat: [%f > %f], Long: [%f > %f]", minLat, maxLat, minLong, maxLong);
                               
                               NSLog(@"(clat: %f, clong: %f", centerLat, centerLong);
                               [map setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(centerLat, centerLong), MKCoordinateSpanMake(latSpan, longSpan))];
                            
                               
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   [map addAnnotations:pinArray];
                               });
                               
                               
                           }];

    

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
	if ([annotation isKindOfClass:[MKPointAnnotation class]])
	{
        
		MKPinAnnotationView*    pinView = (MKPinAnnotationView*)[self.map dequeueReusableAnnotationViewWithIdentifier:@"JustAPin"];
		
		if (!pinView)
		{
			// If an existing pin view was not available, create one.
			pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"JustAPin"];
			pinView.pinColor = MKPinAnnotationColorRed;
			pinView.animatesDrop = YES;
			pinView.canShowCallout = YES;
			
			// Add a detail disclosure button to the callout.
			// TODO: add some info about the location
		}
		else
			pinView.annotation = annotation;
        
		return pinView;
	}
    
	return nil;
}



@end
