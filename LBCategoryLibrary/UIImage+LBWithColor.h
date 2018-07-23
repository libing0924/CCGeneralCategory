//
//  UIImage+LBWithColor.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/7.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LBWithColor)

#pragma mark - 根据颜色生成图片
/**
 *	根据颜色生成矩形图片
 *
 *	@param color			待生成的图片颜色
 *	@param targetSize	生成的图片大小
 *
 *	@return 图片对象
 */
+ (UIImage *)hyb_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize;

/**
 *	根据颜色生成带圆角的图片。当有圆角时，默认被裁剪的圆角部分的颜色为白色。
 *
 *	@param color				待生成的图片颜色
 *	@param targetSize		生成的图片大小
 *	@param cornerRadius	圆角大小
 *
 *	@return 图片对象
 */
+ (UIImage *)hyb_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius;

/**
 *	根据颜色生成带圆角的图片
 *
 *	@param color					待生成的图片颜色
 *	@param targetSize			生成的大小
 *	@param cornerRadius		圆角大小
 *	@param backgroundColor 当有圆角大小时，才需要到此参数。用于设置被裁剪的圆角部分的颜色。
 *
 *	@return 带圆角的图片对象
 */
+ (UIImage *)hyb_imageWithColor:(UIColor *)color
                         toSize:(CGSize)targetSize
                   cornerRadius:(CGFloat)cornerRadius
                backgroundColor:(UIColor *)backgroundColor;

@end
