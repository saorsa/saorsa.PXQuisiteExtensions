////////////////////////////////////////////////////////////////////////////
//
//  NSRelationshipDescription+PXQuisite.m
//  Uraster
//
//  Created by Dragolov,Atanas on 31.05.14.
//  Copyright (c) 2014 г. Uraster. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////
#import "NSRelationshipDescription+PXQuisite.h"
#import "NSPropertyDescription+PXQuisite.h"

@implementation NSRelationshipDescription (PXQuisite)

- (NSDictionary *)dictionaryRepresentation {
    
    NSDictionary * baseInfo = [super dictionaryRepresentation];
    
    NSMutableDictionary * result = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    self.destinationEntity.name ?: [NSNull null], @"destinationEntity",
            self.inverseRelationship.name ?: [NSNull null], @"inverseRelationship",
            [NSNumber numberWithUnsignedInteger:self.maxCount], @"maxCount",
            [NSNumber numberWithUnsignedInteger:self.minCount], @"minCount",
            [NSNumber numberWithBool:self.isToMany], @"isToMany",
            [NSNumber numberWithBool:self.isOrdered], @"isOrdered",
                                    nil];
    
    [result addEntriesFromDictionary:baseInfo];
    
    return result;
}

@end
