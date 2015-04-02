////////////////////////////////////////////////////////////////////////////
//
//  NSEntityDescription+PXQuisite.m
//  Uraster
//
//  Created by Dragolov,Atanas on 31.05.14.
//  Copyright (c) 2014 г. Uraster. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////
#import "NSEntityDescription+PXQuisite.h"
#import "NSAttributeDescription+PXQuisite.h"
#import "NSPropertyDescription+PXQuisite.h"
#import <LINQ4Obj-C/LINQ.h>

@implementation NSEntityDescription (SRS)

- (NSDictionary *)dictionaryRepresentation {
    
    NSArray * subentityInfos = [self.subentities linq_select:^id(NSEntityDescription * item) {
        
        return item.dictionaryRepresentation;
    }];
    
    NSMutableDictionary * result = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    self.managedObjectClassName ?: [NSNull null], @"managedObjectClassName",
                                    self.name ?: [NSNull null], @"name",
            self.userInfo ?: [NSNull null], @"userInfo",
            [NSNumber numberWithBool:self.isAbstract], @"isAbstract",
            subentityInfos ?: [NSNull null], @"subentities",
            nil];
    
    if ( self.attributesByName ) {
        
        NSMutableDictionary * attributeInfos = [NSMutableDictionary new];
        
        for (NSAttributeDescription * item in [self.attributesByName allValues] ) {
         
            [attributeInfos setObject:item.dictionaryRepresentation forKey:item.name];
        }
        
        [result setObject:attributeInfos forKey:@"attributes"];
        
        [result setObject:self.attributesByName.description forKey:@"attributes (stringify)"];
    }
    
    if ( self.relationshipsByName ) {
        
        NSMutableDictionary * relationshipInfos = [NSMutableDictionary new];
        
        for (NSAttributeDescription * item in [self.relationshipsByName allValues] ) {
            
            [relationshipInfos setObject:item.dictionaryRepresentation forKey:item.name];
        }
        
        [result setObject:relationshipInfos forKey:@"relationships"];
        
        [result setObject:self.relationshipsByName.description forKey:@"relationships (stringify)"];
    }
    
    if ( self.versionHashModifier ) {
        
        [result setObject:self.versionHashModifier forKey:@"versionHashModifier"];
    }
    
    if ( self.renamingIdentifier ) {
        
        [result setObject:self.renamingIdentifier forKey:@"renamingIdentifier"];
    }
    
    return result;
}

@end
