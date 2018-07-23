//
//  NSDate+LBFormate.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/7.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "NSDate+LBFormate.h"

@implementation NSDate (LBFormate)

+ (NSString *) timeStringWithTimestamp:(id) timestamp formatterString:(NSString *) formatterStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    
    
    return [self timeStringWithTimestamp:timestamp formatter:formatter];
    
}

+ (NSString *) timeStringWithTimestamp:(id) timestamp formatter:(NSDateFormatter *) formatter {

    if (![timestamp isKindOfClass:[NSString class]] && ![timestamp isKindOfClass:[NSNumber class]]) {
        
        return nil;
    }
    
    NSTimeInterval timeTran = [timestamp doubleValue];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeTran];
    
    return [formatter stringFromDate:date];
}

+ (NSTimeInterval) timeIntervalWithString:(NSString *) timeStr formatterString:(NSString *) formatterStr {

    NSDate *date = [NSDate dateWithTimeString:timeStr timeFormatterString:formatterStr];
    
    return [date timeIntervalSince1970];
}
+ (NSTimeInterval) timeIntervalWithString:(NSString *) timeStr formatter:(NSDateFormatter *) formatter {

    NSDate *date = [NSDate dateWithTimeString:timeStr timeFormatter:formatter];
    
    return [date timeIntervalSince1970];
}

+ (NSDate *) dateWithTimeString:(NSString *) timeStr timeFormatter:(NSDateFormatter *) formatter {

    NSDate *destDate= [formatter dateFromString:timeStr];
    
    return destDate;
}

+ (NSDate *) dateWithTimeString:(NSString *) timeStr timeFormatterString:(NSString *)formatterStr {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    
    return [self dateWithTimeString:timeStr timeFormatter:formatter];
}

- (NSString *) stringWithFormatter:(NSDateFormatter *) formatter {

    return [formatter stringFromDate:self];
}

- (NSString *)stringWithFormatterString:(NSString *)formatterStr {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    
    return [self stringWithFormatter:formatter];
}

+ (NSString *) currentTimeStringWithFormatterString:(NSString *) formatterStr {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    
    return [self currentTimeStringWithFormatter:formatter];
}
+ (NSString *) currentTimeStringWithFormatter:(NSDateFormatter *) formatter {

    NSDate *todate = [NSDate date];
    
    NSString *destDateString = [formatter stringFromDate:todate];
    return destDateString;
}

+ (NSTimeInterval) currentTimeInterval {

    NSDate *currentDate = [NSDate date];
    
    return [currentDate timeIntervalSince1970]; // 此处返回的是东八区的时间戳，不需要手动加上本地时区时间戳[NSTimeZone localTimeZone].secondsFromGMT;
}

+ (NSString *)changeDate:(NSString *)timeStr currentFormater:(NSString *)currentFormatter withFormater:(NSString *)formater {

    NSDate *date = [NSDate dateWithTimeString:timeStr timeFormatterString:currentFormatter];
    
    return [date stringWithFormatterString:formater];
}

@end
