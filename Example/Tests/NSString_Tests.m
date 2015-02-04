
#import <Foundation/Foundation.h>
#import <PXQuisiteExtensions/PXQuisiteExtensions.h>
#import <Kiwi/Kiwi.h>

SPEC_BEGIN(NSStringTests)

describe(@"Testing the extensions to the NSString class", ^{
    
    context(@"Checking empty string values", ^{
        
        NSString * nilString = nil;
        
        NSString * testEmptyString = [NSString empty];
        
        NSString * testStringWithNoTrailingSpaces = @"Test";
        
        NSString * testStringWithTrailingSpaces = @"Test  ";
        
        
        it(@"Can check for NIL string", ^{
            [[theValue([NSString isNilOrEmpty:nilString]) should] equal:theValue(YES)];
        });
        
        it(@"Can check for empty string", ^{
            [[theValue([NSString isNilOrEmpty:testEmptyString]) should] equal:theValue(YES)];
        });
        
        it(@"Can check for not NIL string", ^{
            [[theValue([NSString isNilOrEmpty:testStringWithNoTrailingSpaces]) shouldNot] equal:theValue(YES)];
        });
        
        it(@"Can trim a string", ^{
            [[testStringWithTrailingSpaces.trimmedString should] containString:testStringWithNoTrailingSpaces];
        });
    });
});

SPEC_END