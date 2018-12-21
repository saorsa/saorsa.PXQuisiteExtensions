/////////////////////////////////////////////////////////////////////////////////
//
//  NSManagedObjectModel+PXQuisite.h
//  Auditorium
//
//  Created by Dragolov,Atanas on 21.03.14.
//  Copyright (c) 2014 г. Saorsa. All rights reserved.
//
/////////////////////////////////////////////////////////////////////////////////
#import <CoreData/CoreData.h>

@interface NSManagedObjectModel (PXQuisite)

+ (NSManagedObjectModel *)mergedModelFromMainBundle;

- (NSString *)latestVersionIdentifier;

- (NSDictionary *)developerInfo;

@end
