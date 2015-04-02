////////////////////////////////////////////////////////////////
//
//  NSManagedObject+PXQuisite.m
//  Pods
//
//  Created by Dragolov,Atanas on 2.04.15.
//
////////////////////////////////////////////////////////////////
#import "NSManagedObject+PXQuisite.h"
#import "NSManagedObjectContext+PXQuisite.h"

@implementation NSManagedObject (PXQuisite)

- (NSDictionary *)dictionaryRepresentation {
    
    NSArray * allAttributeKeys = [[[self entity] attributesByName] allKeys];
    
    return [self dictionaryWithValuesForKeys:allAttributeKeys];
}

+ (NSFetchRequest *)fetchRequestForEntity {
    
    NSString * entityClassname = NSStringFromClass(self);
    
    return [NSFetchRequest fetchRequestWithEntityName:entityClassname];
}

+ (NSArray *)fetchAllInContext:(NSManagedObjectContext *)context
                         error:(NSError *__autoreleasing*)error {
    
    __block NSArray * results = nil;
    
    __block NSError * fetchError = nil;
    
    [context performBlockAndWait:^{
        
        results = [context executeFetchRequest:[self fetchRequestForEntity] error:&fetchError];
    }];
    
    if ( fetchError ) {
        
        if ( error != NULL ) {
            
            *error = fetchError;
        }
    }
    
    return results;
}

+ (void)fetchAllInContext:(NSManagedObjectContext *)context
                  success:(void (^)(NSArray * results))success
                  failure:(void (^)(NSError * error))failure {
    
    [context performBlock:^{
        
        NSError * fetchError = nil;
        
        NSArray * results = [context executeFetchRequest:[self fetchRequestForEntity] error:&fetchError];
        
        if ( fetchError ) {
            
            if ( failure != NULL ) {
                
                failure ( fetchError );
            }
        }
        else if ( success ) {
            
            success ( results );
        }
    }];
}

- (void)saveChanges:(void (^)())success
            failure:(void (^)(NSError *error))failure {
    
    [self.managedObjectContext performBlock:^{
        
        __block NSError * error = nil;
        
        BOOL isValid = self.isUpdated ? [self validateForUpdate:&error] : [self validateForInsert:&error];
        
        if ( error || (!isValid) ) {
            
            if ( failure != NULL ) {
                
                failure ( error );
            }
        }
        else {
            
            [self.managedObjectContext smartSave:^(NSArray *inserted, NSArray *updated, NSArray *deleted) {
                
                if ( success != NULL ) {
                    
                    success();
                }
                
            } error:failure];
        }
    }];
}

- (BOOL)saveChangesSynchroniously:(NSError *__autoreleasing*)error {
    
    __block BOOL globalResult = NO;
    
    __block NSError * globalError = nil;
    
    [self.managedObjectContext performBlockAndWait:^{
        
        BOOL isValid = self.isUpdated ? [self validateForUpdate:&globalError] : [self validateForInsert:&globalError];
        
        if ( globalError || (!isValid) ) {
            
            globalResult = NO;
        }
        else {
            
            [self.managedObjectContext smartSaveAndWait:^(NSArray *inserted, NSArray *updated, NSArray *deleted) {
                
                globalResult = YES;
                
                globalError = nil;
                
            } error:^(NSError *error) {
               
                globalResult = NO;
                
                globalError = error;
            }];
        }
    }];
    
    if ( globalError ) {
        
        if ( error != NULL ) {
            
            *error = globalError;
        }
    }
    
    return globalResult;
}

@end
