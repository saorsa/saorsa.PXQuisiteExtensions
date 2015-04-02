/////////////////////////////////////////////////////////////////////////////////
//
//  NSPersistentStoreCoordinator+PXQuisite.h
//  Pods
//
//  Created by Dragolov,Atanas on 2.04.15.
//
/////////////////////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSPersistentStoreCoordinator (PXQuisite)

+ (NSURL *)getURLForDatabaseWithName:(NSString *)databaseFilename;

+ (id)createCoordinatorForModel:(NSManagedObjectModel *)model
           withDatabaseFilename:(NSString *)filename
                          error:(NSError **)error;
+ (id)defaultCoordinator;

- (void)deleteSQLiteDatabaseFiles:(void(^)())successHandler error:(void(^)(NSError * error))errorHandler;

- (NSDictionary *)dictionaryRepresentation;

@end
