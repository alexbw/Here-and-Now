//
//  HANFeatureDetailView.h
//  Here and Now
//
//  Created by Alex Wiltschko on 5/19/12.
//  Copyright (c) 2012 Datta Lab, Harvard University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SensibleTableView/SensibleTableView.h>
#import "HANFeature.h"

@interface HANFeatureDetailView : SCTableViewController

@property (nonatomic, assign) HANFeature *feature;

@end
