
#import <Foundation/Foundation.h>
#import <PXQuisiteExtensions/PXQuisiteExtensions.h>
#import <Kiwi/Kiwi.h>

SPEC_BEGIN(NSDateFormatterTests)

describe(@"Testing the extensions to the NSDateFormatter class", ^{
    
    context(@"Checking NIL and NULL", ^{
        
        NSDate * now = [NSDate date];
        
        NSString * utcString = [[NSDateFormatter UTCDateFormatter] stringFromDate:now];
        
        NSString * localTimeZoneString = [[NSDateFormatter localTimeZoneDateFormatter] stringFromDate:now];
        
        NSString * systemTimeZoneString = [[NSDateFormatter systemTimeZoneDateFormatter] stringFromDate:now];
        
        NSString * defaultTimeZoneString = [[NSDateFormatter defaultTimeZoneDateFormatter] stringFromDate:now];
        
        NSDate * nowFromUTC = [[NSDateFormatter UTCDateFormatter] dateFromString:utcString];
        
        NSDate * nowFromLocalTimeString = [[NSDateFormatter localTimeZoneDateFormatter] dateFromString:localTimeZoneString];
        
        NSDate * nowFromSystemTimeString = [[NSDateFormatter systemTimeZoneDateFormatter] dateFromString:systemTimeZoneString];
        
        NSDate * nowFromDefaultTimeString = [[NSDateFormatter defaultTimeZoneDateFormatter] dateFromString:defaultTimeZoneString];
        
        it(@"Can reformat in UTC", ^{
            [[theValue(round([now timeIntervalSinceDate:nowFromUTC])) should] equal:theValue(0)];
        });
        
        it(@"Can reformat in Local Time Zone", ^{
            [[theValue(round([now timeIntervalSinceDate:nowFromLocalTimeString])) should] equal:theValue(0)];
        });
        
        it(@"Can reformat in System Time Zone", ^{
            [[theValue(round([now timeIntervalSinceDate:nowFromSystemTimeString])) should] equal:theValue(0)];
        });
        
        it(@"Can reformat in Default Time Zone", ^{
            [[theValue(round([now timeIntervalSinceDate:nowFromDefaultTimeString])) should] equal:theValue(0)];
        });
        
    });
    
});

SPEC_END