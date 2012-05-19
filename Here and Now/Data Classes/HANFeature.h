//
//  HANFeature.h
//  Here and Now
//
//  Created by Alex Wiltschko on 5/16/12.
//  Copyright (c) 2012 Datta Lab, Harvard University. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface HANFeature : MKPointAnnotation <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property NSString *type;

@property float latitude;
@property float longitude;

@property NSString *color;
@property NSString *description;
@property NSString *group_name;
@property NSString *icon;

@property NSDate *item_date;
@property NSString *location_name;
@property NSString *openblock_type;
@property NSDate *pub_date;
@property NSDate *start_time;

@property NSString *featureType;
@property NSURL *url;
@property NSString *venue_name;
@property NSString *venue_phone;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
