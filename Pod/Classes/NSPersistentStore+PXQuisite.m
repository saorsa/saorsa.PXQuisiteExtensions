////////////////////////////////////////////////////////////////////////
//
//  NSPersistentStore+PXQuisite.m
//  Pods
//
//  Created by Dragolov,Atanas on 2.04.15.
//
////////////////////////////////////////////////////////////////////////
#import "NSPersistentStore+PXQuisite.h"

@implementation NSPersistentStore (PXQuisite)

- (NSDictionary *)dictionaryRepresentation {
    
    NSDictionary * attributesAtURL = [NSDictionary dictionary];
    
    if ( self.URL != nil && self.URL.isFileURL) {
        
        NSError * ioError = nil;
        
        NSDictionary * fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[self.URL path] error:&ioError];
        
        if ( ioError) {
            
            attributesAtURL = [NSDictionary dictionaryWithObjectsAndKeys:
                               [ioError description], @"ioError.description",
                               [ioError localizedDescription], @"ioError.localizedDescription",
                               @([ioError code]), @"ioError.code",
                               ioError.domain, @"ioError.domain",
                               ioError.userInfo, @"ioError.userInfo",
                               nil];
        }
        else {
            
            attributesAtURL = fileAttributes;
        }
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.configurationName ?: [NSNull null],                                    @"configurationName",
            self.options ?: [NSNull null],                                     @"options",
            self.URL ?: [NSNull null],                                              @"URL",
            attributesAtURL,                                                        @"URLAttributes",
            [NSString stringWithFormat:@"%@ bytes",@(attributesAtURL.fileSize)],    @"fileSize",
            self.identifier ?: @"<NULL>",                                           @"identifier",
            self.metadata ?: [NSDictionary new],                                    @"metadata",
            [NSNumber numberWithBool:self.isReadOnly],                              @"isReadOnly",
            nil];
}

@end
