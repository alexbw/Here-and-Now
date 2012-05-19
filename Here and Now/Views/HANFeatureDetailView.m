//
//  HANFeatureDetailView.m
//  Here and Now
//
//  Created by Alex Wiltschko on 5/19/12.
//  Copyright (c) 2012 Datta Lab, Harvard University. All rights reserved.
//

#import "HANFeatureDetailView.h"

@implementation HANFeatureDetailView
@synthesize feature;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create the Task definition
    SCClassDefinition *featureDef = [SCClassDefinition
                                  definitionWithClass:[HANFeature class]
                                  propertyNamesString:@"title;featureType;description"];
    
    SCPropertyDefinition *titlePropertyDef = [featureDef propertyDefinitionWithName:@"title"];
    titlePropertyDef.type = SCPropertyTypeLabel;
    
    SCPropertyDefinition *typePropertyDef = [featureDef propertyDefinitionWithName:@"featureType"];
    typePropertyDef.type = SCPropertyTypeLabel;
    typePropertyDef.title = @"Type";
    
    
    
    SCPropertyDefinition *descPropertyDef = [featureDef
                                             propertyDefinitionWithName:@"description"];
    descPropertyDef.type = SCPropertyTypeTextView;
    descPropertyDef.attributes = [SCTextViewAttributes attributesWithMinimumHeight:30 maximumHeight:1000 autoResize:YES editable:NO];
    descPropertyDef.title = nil;
    
    // Create an instance of the Task object
    // Create the section(s) for the task object
    [self.tableViewModel generateSectionsForObject:feature
                                    withDefinition:featureDef];
	
    
}


@end
