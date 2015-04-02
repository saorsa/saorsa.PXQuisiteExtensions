////////////////////////////////////////////////////////////////
//
//  NSManagedObject+PXQuisite.h
//  Pods
//
//  Created by Dragolov,Atanas on 2.04.15.
//
////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSManagedObject (PXQuisite)

- (NSDictionary *)dictionaryRepresentation;

+ (NSFetchRequest *)fetchRequestForEntity;

+ (NSArray *)fetchAllInContext:(NSManagedObjectContext *)context
                         error:(NSError *__autoreleasing*)error;

+ (void)fetchAllInContext:(NSManagedObjectContext *)context
                  success:(void (^)(NSArray * results))success
                  failure:(void (^)(NSError * error))failure;

- (void)saveChanges:(void (^)())success
            failure:(void (^)(NSError *error))failure;

- (BOOL)saveChangesSynchroniously:(NSError *__autoreleasing*)error;

@end
