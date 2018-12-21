////////////////////////////////////////////////////////////////////////////
//
//  NSManagedObjectContext+PXQuisite.m
//  Pods
//
//  Created by Dragolov,Atanas on 2.04.15.
//
////////////////////////////////////////////////////////////////////////////
#import "NSManagedObjectContext+PXQuisite.h"
#import "NSPersistentStoreCoordinator+PXQuisite.h"

@implementation NSManagedObjectContext (PXQuisite)

static NSManagedObjectContext * __primaryContext = nil;

+ (id)createChildContext:(NSManagedObjectContext *)parentContext {
    
    return [self createChildContext:parentContext concurrencyType:NSPrivateQueueConcurrencyType];
}

+ (id)createChildContext:(NSManagedObjectContext *)parentContext
         concurrencyType:(NSManagedObjectContextConcurrencyType)concurrencyType {
    
    NSManagedObjectContext * result = [[NSManagedObjectContext alloc] initWithConcurrencyType:concurrencyType];
    
    [result setParentContext:parentContext];
    
    [result setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
    
    return result;
}

+ (id)createPrimaryContext:(NSPersistentStoreCoordinator *)coordinator {
    
    NSManagedObjectContext * result = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    result.persistentStoreCoordinator = coordinator;
    
    result.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy;
    
    return result;
}

+ (void)resetDefaultContext {
    
    @synchronized (self) {
    
        __primaryContext = nil;
    }
}

+ (id)defaultContext {
    
    @synchronized (self) {
        
        if ( !  __primaryContext ) {
            
            if ( [NSThread isMainThread] ) {
                
                NSPersistentStoreCoordinator * defaultCoordinator = [NSPersistentStoreCoordinator defaultCoordinator];
                
                __primaryContext = [self createPrimaryContext:defaultCoordinator];
            }
            else {
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    NSPersistentStoreCoordinator * defaultCoordinator = [NSPersistentStoreCoordinator defaultCoordinator];
                    
                    __primaryContext = [self createPrimaryContext:defaultCoordinator];
                });
            }
        }
        
        return __primaryContext;
    }
}

- (BOOL)isDefaultContext {
    
    return self == [[self class] defaultContext];
}

- (BOOL)isChildContext {
    
    return self.parentContext != nil;
}

- (void)smartSaveAndWait:(void(^)(NSArray * inserted, NSArray * updated, NSArray * deleted))successCallback
                   error:(void(^)(NSError * error))errorCallback {
    
    [self performBlockAndWait:^{
        
        NSArray * inserted = self.insertedObjects.allObjects;
        
        NSArray * updated = self.updatedObjects.allObjects;
        
        NSArray * deleted = self.deletedObjects.allObjects;
        
        __block NSError * saveError = nil;
        
        __block BOOL parentContextSaved = NO;
        
        if ( self.hasChanges ) {
            
            if ( [self save:&saveError] ) {
                
                if ( self.parentContext ) {
                    
                    [self.parentContext performBlockAndWait:^{
                        
                        parentContextSaved = [self.parentContext save:&saveError];
                    }];
                    
                    if ( parentContextSaved ) {
                        
                        if ( successCallback != NULL ) {
                            
                            successCallback ( inserted, updated, deleted );
                        }
                    }
                    else if ( errorCallback != NULL ) {
                        
                        errorCallback ( saveError );
                    }
                }
                else if ( successCallback != NULL ) {
                    
                    successCallback ( inserted, updated, deleted );
                }
            }
            else if ( errorCallback != NULL ) {
                
                errorCallback ( saveError );
            }
        }
        else if ( successCallback != NULL ) {
            
            successCallback ( inserted, updated, deleted );
        }
    }];
    
}

- (void)smartSave:(void(^)(NSArray * inserted, NSArray * updated, NSArray * deleted))successCallback
            error:(void(^)(NSError * error))errorCallback {
    
    [self performBlock:^{
        
        NSArray * inserted = self.insertedObjects.allObjects;
        
        NSArray * updated = self.updatedObjects.allObjects;
        
        NSArray * deleted = self.deletedObjects.allObjects;
        
        __block NSError * saveError = nil;
        
        __block BOOL parentContextSaved = NO;
        
        if ( self.hasChanges ) {
            
            if ( [self save:&saveError] ) {
                
                if ( self.parentContext ) {
                    
                    [self.parentContext performBlockAndWait:^{
                        
                        parentContextSaved = [self.parentContext save:&saveError];
                    }];
                    
                    if ( parentContextSaved ) {
                        
                        if ( successCallback != NULL ) {
                            
                            successCallback ( inserted, updated, deleted );
                        }
                    }
                    else if ( errorCallback != NULL ) {
                        
                        errorCallback ( saveError );
                    }
                }
                else if ( successCallback != NULL ) {
                    
                    successCallback ( inserted, updated, deleted );
                }
            }
            else if ( errorCallback != NULL ) {
                
                errorCallback ( saveError );
            }
        }
        else if ( successCallback != NULL ) {
            
            successCallback ( inserted, updated, deleted );
        }
    }];
}

- (NSDictionary *)dictionaryRepresentation {
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:self.hasChanges],              @"hasChanges",
            [self.registeredObjects allObjects],                    @"registeredObjects",
            [self.insertedObjects allObjects],                      @"insertedObjects",
            [self.updatedObjects allObjects],                       @"updatedObjects",
            [self.deletedObjects allObjects],                       @"deletedObjects",
            nil];
}

@end
