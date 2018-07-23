//
//  NSDate+LBFormate.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/7.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>

// 注意一下几点

// NSDate *date = [NSDate date]该函数返回的是0区的date对象
// 但是[formatter stringFromDate:date]格式化后会自动转换为当前时区的时间字符串对象。[date timeIntervalSince1970]转为时间戳后为当前时区的时间戳

// //y-年 M-月 d-天 h-12小时制时 H-24小时制时 m-分 s-秒 S-毫秒 EEE-周几 EEEE-星期几 EEEEE-几
// 相关类NSCalendar NSDateComponents


@interface NSDate (LBFormate)

#pragma mark 时间、时间戳、时间字符串转换

// WARN 以下涉及到传入格式化字符串或者格式化对象的时候传入nil的时候默认@"yyyy/MM/dd HH:mm:ss" 格式

/**
 * 时间戳 -> 时间字符串
 * 输入：1488870078 @“yyyy/MM/dd HH:mm:ss”
 * return：2017/3/7 15:1:18
 */
+ (NSString *) timeStringWithTimestamp:(id) timestamp formatterString:(NSString *) formatterStr;
+ (NSString *) timeStringWithTimestamp:(id) timestamp formatter:(NSDateFormatter *) formatter;

/**
 * 时间字符串 -> 时间戳 这里计算的是从1970计算的时间戳
 * 输入：@"2017/3/7 15:1:18" @“yyyy/MM/dd HH:mm:ss”
 * return：1488870078
 */
+ (NSTimeInterval) timeIntervalWithString:(NSString *) timeStr formatterString:(NSString *) formatterStr;
+ (NSTimeInterval) timeIntervalWithString:(NSString *) timeStr formatter:(NSDateFormatter *) formatter;

/**
 * 时间字符串 -> date对象
 * 输入：@“2017/3/7 15:1:18” @“yyyy/MM/dd HH:mm:ss”
 * return：NSDate object
 */
+ (NSDate *) dateWithTimeString:(NSString *) timeStr timeFormatterString:(NSString *) formatterStr;
+ (NSDate *) dateWithTimeString:(NSString *) timeStr timeFormatter:(NSDateFormatter *) formatter;

/**
 * date对象 -> 时间字符串
 * 输入：@“yyyy/MM/dd HH:mm:ss”
 * return：@“2017/3/7 15:1:18”
 */
- (NSString *) stringWithFormatterString:(NSString *) formatterStr;
- (NSString *) stringWithFormatter:(NSDateFormatter *) formatter;

/**
 * 当前时间 -> 时间字符串
 * 输入：@“yyyy/MM/dd HH:mm:ss”
 * return：@“2017/3/7 15:1:18”
 */
+ (NSString *) currentTimeStringWithFormatterString:(NSString *) formatterStr;
+ (NSString *) currentTimeStringWithFormatter:(NSDateFormatter *) formatter;

/**
 * 2017/3/7 15:1:18 -> 2017/3/7 15-1-18
 * 输入：@“2017/3/7 15:1:18” @“yyyy/MM/dd HH:mm:ss” @“yyyy/MM/dd HH-mm-ss”
 * return：@“2017/3/7 15-1-18”
 */
+ (NSString *)changeDate:(NSString *)timeStr currentFormater:(NSString *) currentFormatter withFormater:(NSString *) formater;

// 1970到此刻时间戳
+ (NSTimeInterval) currentTimeInterval;






@end
