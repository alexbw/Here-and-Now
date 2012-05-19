//
//  FirstViewController.m
//  Here and Now
//
//  Created by Alex Wiltschko on 5/13/12.
//  Copyright (c) 2012 Datta Lab, Harvard University. All rights reserved.
//

#import "FirstViewController.h"
#import "HANFeatureDetailView.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize map;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
                                   
                                   HANFeature *aFeature = [[HANFeature alloc] initWithDictionary:feature];
                                   
                                   minLong = MIN(minLong, aFeature.longitude);
                                   maxLong = MAX(maxLong, aFeature.longitude);
                                   minLat = MIN(minLat, aFeature.latitude);
                                   maxLat = MAX(maxLat, aFeature.latitude);
                                   
                                   
                                   [pinArray addObject:aFeature];
                                   
                               }
                               
                               float latSpan = (maxLat - minLat)*1.01;
                               float longSpan = (maxLong - minLong)*1.01;
                               float centerLat = (maxLat + minLat) / 2.0;
                               float centerLong = (minLong + maxLong) / 2.0;
                               
                               
                               [map setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(centerLat, centerLong), MKCoordinateSpanMake(latSpan, longSpan))];
                               
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   [map addAnnotations:pinArray];
                               });
                               
                               
                           }];

    

}


- (void)showFeatureDetail:(id)sender
{
    NSLog(@"Got somethin from %@", sender);
    HANFeature *feature = (HANFeature *)[[self.map selectedAnnotations] objectAtIndex:0];
    NSLog(@"Should push a feature: %@", feature.title);
    
    HANFeatureDetailView *detailVC = [[HANFeatureDetailView alloc] init];
    detailVC.feature = feature;
    [self.navigationController pushViewController:detailVC animated:YES];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
	if ([annotation isKindOfClass:[HANFeature class]])
	{
        
		MKPinAnnotationView* pinView = (MKPinAnnotationView *)[self.map dequeueReusableAnnotationViewWithIdentifier:@"HANAnnotationView"];
		
		if (!pinView)
		{
			// If an existing pin view was not available, create one.
			pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"HANAnnotationView"];
			pinView.pinColor = MKPinAnnotationColorRed;
			pinView.animatesDrop = YES;
			pinView.canShowCallout = YES;
			
			// Add a detail disclosure button to the callout.
			// TODO: add some info about the location
            UIButton* rightButton = [UIButton buttonWithType:
                                     UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self action:@selector(showFeatureDetail:)
                  forControlEvents:UIControlEventTouchUpInside];
            pinView.rightCalloutAccessoryView = rightButton;
            
		}
		else
			pinView.annotation = annotation;
        
		return pinView;
	}
    
	return nil;
}



@end
