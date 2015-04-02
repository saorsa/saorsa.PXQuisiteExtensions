/////////////////////////////////////////////////////////////////////////////////
//
//  NSPersistentStoreCoordinator+PXQuisite.m
//  Pods
//
//  Created by Dragolov,Atanas on 2.04.15.
//
/////////////////////////////////////////////////////////////////////////////////
#import "NSPersistentStoreCoordinator+PXQuisite.h"
#import "NSPersistentStore+PXQuisite.h"
#import "NSManagedObjectModel+PXQuisite.h"
#import "UIApplication+PXQuisite.h"
#import <LINQ4Obj-C/LINQ.h>

@implementation NSPersistentStoreCoordinator (PXQuisite)

static NSPersistentStoreCoordinator * __defaultPSCoordinator;

+ (NSURL *)getURLForDatabaseWithName:(NSString *)databaseFilename {
    
    NSString * documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString * path = [documentsDir stringByAppendingPathComponent:databaseFilename];
    
    return [NSURL fileURLWithPath:path];
}

+ (id)createCoordinatorForModel:(NSManagedObjectModel *)model
           withDatabaseFilename:(NSString *)filename
                          error:(NSError **)error {
    
    NSPersistentStoreCoordinator * result = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSURL * storeUrl = [[self class] getURLForDatabaseWithName:filename];
    
    [result addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
                                   URL:storeUrl
                               options:[NSDictionary dictionary]
                                 error:error];
    
    return result;
}

+ (id)defaultCoordinator {
    
    @synchronized (self) {
        
        if ( ! __defaultPSCoordinator ) {
            
            NSManagedObjectModel * mergedModel = [NSManagedObjectModel mergedModelFromMainBundle];
            
            NSError * error = nil;
            
            NSString * dbName = [NSString stringWithFormat:@"%@-v%@.sqlite",
                                 [UIApplication sharedApplication].bundleIdentifier,
                                 [mergedModel latestVersionIdentifier]];
            
            __defaultPSCoordinator = [self createCoordinatorForModel:mergedModel withDatabaseFilename:dbName error:&error];
            
            if ( error ) {
                
                
                
                @throw [NSException exceptionWithName:@"CoreDataException" reason:[error localizedDescription] userInfo:@{}];
            }
        }
        
        return  __defaultPSCoordinator;
    }
}

- (void)deleteSQLiteDatabaseFiles:(void(^)())successHandler error:(void(^)(NSError * error))errorHandler {
    
    @synchronized ( self ) {
        
        NSArray * allStores = [self.persistentStores linq_where:^BOOL(id item) {
            
            return [item isKindOfClass:[NSPersistentStore class]] && [[((NSPersistentStore *)item) type] isEqualToString:NSSQLiteStoreType];
        }];
        
        BOOL success = YES;
        
        for (NSPersistentStore * store in allStores) {
            
            NSURL * storeUrl = store.URL;
            
            NSError * storeError = nil;
            
            if ( ! [self removePersistentStore:store error:&storeError] ) {
                
                if ( errorHandler != NULL ) {
                    
                    errorHandler ( storeError );
                }
                
                success = NO;
                
                break;
            }
            
            if ( ! [[NSFileManager defaultManager] removeItemAtURL:storeUrl error:&storeError] ) {
                
                if ( errorHandler != NULL ) {
                    
                    errorHandler ( storeError );
                }
                
                success = NO;
                
                break;
            }
            
            [self addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
                                         URL:storeUrl
                                     options:[NSDictionary dictionary]
                                       error:&storeError];
            
            if ( storeError ) {
                
                if ( errorHandler != NULL ) {
                    
                    errorHandler ( storeError );
                }
                
                success = NO;
                
                break;
            }
        }
        
        if ( success ) {
            
            if ( successHandler != NULL ) {
                
                successHandler ();
            }
        }
    }
}

- (NSDictionary *)dictionaryRepresentation {
    
    NSArray * persistentStoreInfos = [[self persistentStores] linq_select:^id(NSPersistentStore * item) {
        
        return [item dictionaryRepresentation];
    }];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            persistentStoreInfos ?: [NSArray array], @"persistentStores",
            [NSPersistentStoreCoordinator registeredStoreTypes] ?: [NSArray array], @"registeredStoreTypes",
            nil];
}

@end
