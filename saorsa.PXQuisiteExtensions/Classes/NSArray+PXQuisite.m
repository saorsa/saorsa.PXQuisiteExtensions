/////////////////////////////////////////////////////////////////////////////////
//
//  NSArray+PXQuisite.m
//  Pods
//
//  Created by Dragolov,Atanas on 1.02.15.
//
/////////////////////////////////////////////////////////////////////////////////
#import "NSArray+PXQuisite.h"
#import "NSMutableDictionary+PXQuisite.h"

@implementation NSArray (PXQuisite)

- (NSArray *)deepCopy {
    
    NSUInteger count = [self count];
    
    id cArray[count];
    
    for (unsigned int i = 0; i < count; ++i) {
        
        id obj = [self objectAtIndex:i];
        
        if ([obj respondsToSelector:@selector(deepCopy)])
        
            cArray[i] = [obj deepCopy];
        else
            
            cArray[i] = [obj copy];
    }
    
    NSArray *result = [NSArray arrayWithObjects:cArray count:count];
    
    return result;
}

- (NSMutableArray *)mutableDeepCopy {
    
    NSUInteger count = [self count];
    
    id cArray[count];
    
    for (unsigned int i = 0; i < count; ++i) {
        
        id obj = [self objectAtIndex:i];
        
        // Try to do a deep mutable copy, if this object supports it
        if ([obj respondsToSelector:@selector(mutableDeepCopy)])
            cArray[i] = [obj mutableDeepCopy];
        
        // Then try a shallow mutable copy, if the object supports that
        else if ([obj respondsToSelector:@selector(mutableCopyWithZone:)])
            cArray[i] = [obj mutableCopy];
        
        // Next try to do a deep copy
        else if ([obj respondsToSelector:@selector(deepCopy)])
            cArray[i] = [obj deepCopy];
        
        // If all else fails, fall back to an ordinary copy
        else
            cArray[i] = [obj copy];
    }
    
    NSMutableArray *result = [NSMutableArray arrayWithObjects:cArray count:count];
    
    return result;
}

- (NSString *)jsonify:(NSError *__autoreleasing*)error {
    
    return [self jsonifyWithOptions:NSJSONWritingPrettyPrinted error:error];
}

- (NSString *)jsonifyWithOptions:(NSJSONWritingOptions)options error:(NSError *__autoreleasing*)error {
    
    NSError * serializeError = nil;
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:self options:options error:&serializeError];
    
    if ( ! serializeError ) {
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        return jsonString;
    }
    else if ( error != NULL ) {
        
        *error = serializeError;
    }
    
    return nil;
}

@end
