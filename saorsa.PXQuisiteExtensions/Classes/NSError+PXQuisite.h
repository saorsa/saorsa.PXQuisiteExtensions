/////////////////////////////////////////////////////////////////////////////////
//
//  NSError+PXQuisite.h
//  Pods
//
//  Created by Dragolov,Atanas on 1.02.15.
//
/////////////////////////////////////////////////////////////////////////////////
#import <Foundation/Foundation.h>

@interface NSError (PXQuisite)

+ (instancetype)errorFromException:(NSException *)exception;

- (NSDictionary *)dictionaryRepresentation;

@end
