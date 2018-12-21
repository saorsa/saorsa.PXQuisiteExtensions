////////////////////////////////////////////////////////////////////////////
//
//  NSManagedObjectContext+PXQuisite.h
//  Pods
//
//  Created by Dragolov,Atanas on 2.04.15.
//
////////////////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (PXQuisite)

@property (nonatomic, readonly) BOOL isDefaultContext;

@property (nonatomic, readonly) BOOL isChildContext;

+ (void)resetDefaultContext;

+ (id)createPrimaryContext:(NSPersistentStoreCoordinator *)coordinator;

+ (id)createChildContext:(NSManagedObjectContext *)parentContext
         concurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType;

+ (id)createChildContext:(NSManagedObjectContext *)parentContext;

+ (id)defaultContext;

- (void)smartSaveAndWait:(void(^)(NSArray * inserted, NSArray * updated, NSArray * deleted))successCallback
                   error:(void(^)(NSError * error))errorCallback;

- (void)smartSave:(void(^)(NSArray * inserted, NSArray * updated, NSArray * deleted))successCallback
            error:(void(^)(NSError * error))errorCallback;

- (NSDictionary *)dictionaryRepresentation;

@end
