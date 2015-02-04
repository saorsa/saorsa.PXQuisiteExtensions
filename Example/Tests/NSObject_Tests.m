
#import <Foundation/Foundation.h>
#import <PXQuisiteExtensions/PXQuisiteExtensions.h>
#import <Kiwi/Kiwi.h>

SPEC_BEGIN(NSObjectTests)

describe(@"Testing the extensions to the NSObject class", ^{
    
    context(@"Checking NIL and NULL", ^{
        
        NSObject * nilObject = nil;
        
        NSObject * nullObject = [NSNull null];
        
        it(@"Can check for NIL with nil value", ^{
            [[theValue([NSObject isObjectNil:nilObject]) should] equal:theValue(YES)];
        });
        
        it(@"Can check for NIL with NSNull value", ^{
            [[theValue([NSObject isObjectNil:nullObject]) should] equal:theValue(NO)];
        });
        
        it(@"Can check for not NIL for object instances", ^{
            [[theValue([NSObject isObjectNil:[NSObject new]]) shouldNot] equal:theValue(YES)];
        });
        
        it(@"Can check for NSNull with NSNull value", ^{
            [[theValue([nullObject isNull]) should] equal:theValue(YES)];
        });
        
        it(@"Can check for not NSNull with object instances", ^{
            [[theValue([[NSObject new] isNull]) shouldNot] equal:theValue(YES)];
        });
    });
    
});

SPEC_END