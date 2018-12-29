//
//  NSString+LBVerification.h
//  LBCategoryLibrary
//
//  Created by smufs on 2015/3/7.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CCGeneral)

/** 检查是否只包含字母和数字*/
- (BOOL) isOnlyLeterAndNumber;

/** 检验手机*/
- (BOOL) isTelephoneNumber;

// 是否包含emoji字符
- (BOOL)containsEmoji;

/** 检验空字符 为空返回true*/
- (BOOL) isEmpty;

/** 检验数字格式并返回*/
- (NSString *)checkAmountString;

/** 检查是否包含特殊字符串*/
- (BOOL) hasSpecialString;

/** json转nsdictionary或者array*/
- (id)JSONStringConvert;

// 字节长度
-(int)bytesLength;

/** 检查是否为汉字*/
- (BOOL)isChinese;

/** 检查是否为邮箱*/
- (BOOL) isEmailAddress;


@end
