////////////////////////////////////////////////////////////////////////////
//
//  NSPropertyDescription+SRS.m
//  Uraster
//
//  Created by Dragolov,Atanas on 31.05.14.
//  Copyright (c) 2014 г. Uraster. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////
#import "NSPropertyDescription+PXQuisite.h"

@implementation NSPropertyDescription (PXQuisite)

- (NSDictionary *)dictionaryRepresentation {
 
    return [NSDictionary dictionaryWithObjectsAndKeys:
            
            self.name ?: [NSNull null],                     @"name",
            [NSNumber numberWithBool:self.isTransient],     @"isTransient",
            [NSNumber numberWithBool:self.isOptional],      @"isOptional",
            [NSNumber numberWithBool:self.isIndexed],       @"isIndexed",
            self.renamingIdentifier ?: [NSNull null],       @"renamingIdenifier",
            self.versionHashModifier ?: [NSNull null],      @"versionHashModifier",
            self.userInfo ?: [NSNull null],                 @"userInfo",
            
            nil];
}

@end
