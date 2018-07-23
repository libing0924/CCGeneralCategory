//
//  UIColor+LBExtend.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LBExtend)

// 根据十六进制换算iOS色彩空间 输入：0xFFFFFF
+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;

// 根据十六进制字符串换算iOS色彩空间 输入：@"0xFFFFFF"
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)alph;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

// 根据色彩空间返回十六进制字符串
+ (NSString *) hexFromUIColor: (UIColor*) color;

@end
