//
//  NSString+LBExtend.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 range的校验结果
 */
typedef enum : NSUInteger {
    RangeCorrect = 0,
    RangeError = 1,
    RangeOut = 2,
}RangeFormatType;

@interface NSString (LBExtend)

/**
 *   计算指定字体的大小
 *
 *  @param font 字体
 *
 *  @return 高度
 */
- (CGSize) sizeWithFont:(UIFont *) font;
- (CGRect) rectWithFont:(UIFont *) font;
- (CGRect) rectWithFont:(UIFont *) font width:(CGFloat) width;

/**
 *  字符串百分号编码
 *
 *  @param resource 需要编码的字符串
 *
 *  @return 编码后字符串
 */
- (NSString *)URLEncodedString:(NSString*)resource ;

/**
 *  校验范围（NSRange）
 *
 *  @param range Range
 *
 *  @return 校验结果：RangeFormatType
 */
- (RangeFormatType)checkRange:(NSRange)range;

///过滤字符串
+ (NSString *)subCharacterSetWithCharactersInString:(NSString *)string willDeleteStr:(NSString *)str;
+ (NSString *)subCharacterSetWithCharactersInString:(NSString *)string willDeleteStr:(NSString *)str replace:(NSString *)st;

#pragma mark - 富文本相关

/**
 *  改变字体的颜色
 *
 *  @param color 颜色（UIColor）
 *  @param range 范围（NSRange）
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)changeColor:(UIColor *)color
                                  range:(NSRange)range;

/**
 *  改变字体大小
 *
 *  @param font  字体大小(UIFont)
 *  @param range 范围(NSRange)
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)changeFont:(UIFont *)font
                                 range:(NSRange)range;

/**
 *   改变字体的颜色和大小
 *
 *  @param color      字符串的颜色
 *  @param colorRange 需要改变颜色的字符串范围
 *  @param font       字体大小
 *  @param fontRange  需要改变字体大小的字符串范围
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */

- (NSMutableAttributedString *)changeColor:(UIColor *)color
                              colorRang:(NSRange)colorRange
                                   andFont:(UIFont *)font
                              fontRange:(NSRange)fontRange;

#pragma mark - 改变多个范围内的字体和颜色

/**
 *  改变多段字符串为一种颜色
 *
 *  @param color  字符串的颜色
 *  @param ranges 范围数组:[NSValue valueWithRange:NSRange]
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)changeColor:(UIColor *)color ranges:(NSArray<NSValue *> *)ranges;

/**
 *  改变多段字符串为同一大小
 *
 *  @param font   字体大小
 *  @param ranges 范围数组:[NSValue valueWithRange:NSRange]
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)changeFont:(UIFont *)font ranges:(NSArray<NSValue *> *)ranges;

/**
 *  行间距设置
 *
 *  @param lineSpacing 行间距
 *
 *  @return 富文本
 */
- (NSMutableAttributedString *)lineSpacing:(NSInteger)lineSpacing;


@end
