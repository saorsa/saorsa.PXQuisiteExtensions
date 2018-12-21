/////////////////////////////////////////////////////////////////////////////////
//
//  NSManagedObjectModel+PXQuisite.m
//  Auditorium
//
//  Created by Dragolov,Atanas on 21.03.14.
//  Copyright (c) 2014 г. Saorsa. All rights reserved.
//
/////////////////////////////////////////////////////////////////////////////////
#import "NSManagedObjectModel+PXQuisite.h"
#import "NSPropertyDescription+PXQuisite.h"
#import "NSEntityDescription+PXQuisite.h"

@implementation NSManagedObjectModel (PXQuisite)

+ (NSManagedObjectModel *)mergedModelFromMainBundle {
    
    NSManagedObjectModel * result = [NSManagedObjectModel mergedModelFromBundles:[NSArray arrayWithObject:[NSBundle mainBundle]]];

    if ( ! result ) {
     
        @throw [NSException exceptionWithName:@"CoreDataException" reason:@"Failed to create a merged managed object model for the data models in the main application bundle." userInfo:@{}];
    }
    
    return result;
}

- (NSString *)latestVersionIdentifier {

    NSSet * versions = [self versionIdentifiers];
    
    if ( [versions count] > 0 ) {
     
        return  [NSString stringWithFormat:@"%lu", (unsigned long)[versions count]];
    }

    return @"1.0";
}

- (NSDictionary *)developerInfo {
    
    NSMutableDictionary * entitiesInfo = [NSMutableDictionary new];

    for (NSEntityDescription *item in self.entities) {
        
        [entitiesInfo setObject:[item dictionaryRepresentation] forKey:item.name];
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            entitiesInfo, @"entities",
            self.localizationDictionary ?: [NSNull null], @"localizationDictionary",
            nil];
}

@end
