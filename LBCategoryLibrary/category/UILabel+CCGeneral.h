//
//  UILabel+LBExtend.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

/**
 * 一般用来计算label的文字大小，以此来约束label的frame
 *
 */

#import <UIKit/UIKit.h>

@interface UILabel (CCGeneral)

@property (nonatomic, assign, readonly) CGFloat lb_textWidth;

@property (nonatomic, assign, readonly) CGFloat lb_textHeight;

- (CGSize) labelSizeWithMaxWidth:(CGFloat) width textFont:(UIFont *) font;


/**
 font:14
 color:323232
 
 @return label
 */
+ (instancetype) defaultBlackMediumLabel;

/**
 font:12
 color:323232
 
 @return label
 */
+ (instancetype) defaultBlackLittleLabel;

/**
 font:10
 color:323232
 
 @return label
 */
+ (instancetype) defaultBlackMinimumLabel;

/**
 font:14
 color:969696
 
 @return label
 */
+ (instancetype) defaultGrayMediumLabel;

/**
 font:12
 color:969696
 
 @return label
 */
+ (instancetype) defaultGrayLittleLabel;

/**
 font:10
 color:969696
 
 @return label
 */
+ (instancetype) defaultGrayMinimumLabel;

@end
