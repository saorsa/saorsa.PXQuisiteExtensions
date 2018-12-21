////////////////////////////////////////////////////////////////////////////
//
//  NSAttributeDescription+PXQuisite.m
//  Uraster
//
//  Created by Dragolov,Atanas on 31.05.14.
//  Copyright (c) 2014 г. Uraster. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////
#import "NSAttributeDescription+PXQuisite.h"
#import "NSPropertyDescription+PXQuisite.h"

@implementation NSAttributeDescription (SRS)

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary * result = [NSMutableDictionary dictionaryWithDictionary:[super dictionaryRepresentation]];
    
    [result setObject:[NSNumber numberWithUnsignedInteger:self.attributeType] forKey:@"attributeType"];
    
    [result setObject:self.attributeValueClassName forKey:@"attributeValueClassName"];
    
    return result;
}

@end
