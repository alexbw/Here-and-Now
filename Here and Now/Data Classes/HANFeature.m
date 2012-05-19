//
//  HANFeature.m
//  Here and Now
//
//  Created by Alex Wiltschko on 5/16/12.
//  Copyright (c) 2012 Datta Lab, Harvard University. All rights reserved.
//

#import "HANFeature.h"

@implementation HANFeature

@synthesize title, subtitle, coordinate;

@synthesize type;
@synthesize latitude;
@synthesize longitude;

@synthesize color;
@synthesize description;
@synthesize group_name;
@synthesize icon;

@synthesize item_date;
@synthesize location_name;
@synthesize openblock_type;
@synthesize pub_date;
@synthesize start_time;
@synthesize featureType;
@synthesize url;
@synthesize venue_name;
@synthesize venue_phone;


- (id)initWithDictionary:(NSDictionary *)d;
{
    self = [super init];
    if (self)
    {
                
        type = [d objectForKey:@"type"];
        NSDictionary *p = [d objectForKey:@"properties"];
        
        title = [p objectForKey:@"title"];
        subtitle = @"";
        
        description = [p objectForKey:@"description"];
        group_name = [p objectForKey:@"group_name"];
        icon = [p objectForKey:@"icon"];
        item_date = [p objectForKey:@"item_date"];
        location_name = [p objectForKey:@"location_name"];
        openblock_type = [p objectForKey:@"openblock_type"];
        pub_date = [p objectForKey:@"pub_date"];
        start_time = [p objectForKey:@"start_time"];
        featureType = [p objectForKey:@"type"];
        url = [NSURL URLWithString:[p objectForKey:@"url"]];
        venue_name = [p objectForKey:@"venue_name"];
        venue_phone = [p objectForKey:@"venue_phone"];
        
        NSArray *coords = [[d objectForKey:@"geometry"] objectForKey:@"coordinates"];        
        
        longitude = [[coords objectAtIndex:0] floatValue];
        latitude = [[coords objectAtIndex:1] floatValue];
        coordinate = CLLocationCoordinate2DMake(latitude, longitude);

        
    }
    
    return self;
}


@end
