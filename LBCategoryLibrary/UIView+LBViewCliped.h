//
//  UIView+LBViewCliped.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/7.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	裁剪后的图片
 *
 *	@param clipedImage 裁剪后的图片
 */
typedef void(^HYBClipedCallback)(UIImage *clipedImage);

@interface UIView (LBViewCliped)

#pragma mark - 边框相关属属性，仅对生成圆形图片和矩形图片有效
/**
 *	默认为1.0，当小于0时，不会添加边框，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, assign) CGFloat lb_borderWidth;
/**
 *	当小于0时，不会添加边框。默认为0.仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, assign) CGFloat lb_pathWidth;
/**
 *	边框线的颜色，默认为[UIColor lightGrayColor]，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor *lb_borderColor;
/**
 *	Path颜色，默认为白色。仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor *lb_pathColor;

/**
 * UIView及子类切圆角
 *
 */

- (void) lb_addCornerRadius:(CGFloat) radius;

- (void) lb_addCorner:(UIRectCorner) corner cornerRadius:(CGFloat) radius;

- (void) lb_addCornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize;

- (void) lb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize;

#pragma mark - 生成适应大小的图片显示
/**
 *	使用指定的图片来填充，充当UIImageView。
 *  对于自动布局的控件，如果在设置图片时，没有指定大小，就无法得到正确的图片大小。
 *
 *	@param image	图片名称或者图片对象，甚至支持NSData
 *	@param isEqualScale 是否是等比例缩放
 *  @param targetSize 图片大小。如果没有此参数，表示使用控件本身的大小。
 *  @parma callback   只有当图片真正被裁剪成功后，才会回调，返回裁剪后的图片
 *
 *	@return 裁剪前的图片
 */
- (UIImage *)hyb_setImage:(id)image size:(CGSize)targetSize isEqualScale:(BOOL)isEqualScale onCliped:(HYBClipedCallback)callback;
/**
 * 使用指定的图片来填充图片。对于在填充图片之前，肯定有控件大小的，可以直接使用些API。
 */
- (UIImage *)hyb_setImage:(id)image isEqualScale:(BOOL)isEqualScale onCliped:(HYBClipedCallback)callback;

#pragma mark - 生成圆形图片显示
/**
 *	使用指定的图片来填充，但是生成的是圆形图片，背景颜色为白色。
 *
 *	@param image			图片名称或者图片对象，甚至支持NSData
 *	@param targetSize	生成指定大小的图片
 *	@param isEqualScale	是否等比例缩放图片
 *  @param backgroundColor 图片背景颜色
 *  @parma callback   只有当图片真正被裁剪成功后，才会回调，返回裁剪后的图片
 *
 *	@return 裁剪前的图片
 */
- (UIImage *)hyb_setCircleImage:(id)image
                           size:(CGSize)targetSize
                   isEqualScale:(BOOL)isEqualScale
                 backgrounColor:(UIColor *)backgroundColor
                       onCliped:(HYBClipedCallback)callback;
/// 使用指定的图片来填充，但是生成的是圆形图片，背景颜色为白色。
- (UIImage *)hyb_setCircleImage:(id)image
                           size:(CGSize)targetSize
                   isEqualScale:(BOOL)isEqualScale
                       onCliped:(HYBClipedCallback)callback;
/**
 *  使用指定的图片来填充，但是生成的是圆形图片，默认背景颜色为白色。当调用此API时，若控件本身
 *  已经有确定的大小，则可以直接使用此API
 */
- (UIImage *)hyb_setCircleImage:(id)image
                   isEqualScale:(BOOL)isEqualScale
                       onCliped:(HYBClipedCallback)callback;

#pragma mark - 生成四个带圆角图片来填充
/**
 *	使用指定图片来填充，生成带四个圆角的图片来填充。生成的图片带有圆角后，为了解决图层混合，需要指定
 *  背景颜色，以便在生成的图片颜色与控件背景颜色一致，可提高性能。
 *
 *	@param image						图片名称或者图片对象，甚至支持NSData
 *	@param targetSize			  生成的图片目标大小
 *	@param cornerRaidus		  圆角大小
 *	@param backgroundColor	背景颜色，用于解决图层混合。
 *	@param isEqualScale			是否等比例缩放图片
 *  @parma callback   只有当图片真正被裁剪成功后，才会回调，返回裁剪后的图片
 *
 *	@return 裁剪前的图片
 */
- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
          backgroundColor:(UIColor *)backgroundColor
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(HYBClipedCallback)callback;
/**
 * 生成带四个圆角的图片，默认使用白色背景、isEqualScale=YES
 */
- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
                 onCliped:(HYBClipedCallback)callback;

/**
 * 生成带四个圆角的图片，默认使用白色背景、isEqualScale=YES。当调用此API时，若控件本身大小是确定的，才能起效！
 */
- (UIImage *)hyb_setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus
                 onCliped:(HYBClipedCallback)callback;

#pragma mark - 生成任意圆角图片来填充
/**
 *	生成任意圆角的图片来填充控件。
 *
 *	@param image						图片名称或者图片对象，甚至支持NSData
 *	@param targetSize			  生成图片大小
 *	@param cornerRaidus		  圆角大小
 *	@param rectCorner			  指定哪些添加圆角。如果有多个圆角，可以这样UIRectCornerTopRight|UIRectCornerTopLeft
 *	@param backgroundColor	当带有圆角时，背景颜色可用于解决图层混合问题。
 *	@param isEqualScale			是否等比例缩放图片
 *  @parma callback   只有当图片真正被裁剪成功后，才会回调，返回裁剪后的图片
 *
 *	@return 裁剪前的图片
 */
- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
          backgroundColor:(UIColor *)backgroundColor
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(HYBClipedCallback)callback;
/**
 * 生成任意圆角的图片来填充控件。默认背景色为白色、isEqualScale=YES
 */
- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
                 onCliped:(HYBClipedCallback)callback;
/**
 * 生成任意圆角的图片来填充控件。默认背景色为白色。如果控件本身大小确定，
 * 可以直接使用此API来生成与控件大小相同的图片来填充。
 */
- (UIImage *)hyb_setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(HYBClipedCallback)callback;
/**
 * 生成任意圆角的图片来填充控件。默认背景色为白色、isEqualScale=YES。如果控件本身大小确定，
 * 可以直接使用此API来生成与控件大小相同的图片来填充。
 */
- (UIImage *)hyb_setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
                 onCliped:(HYBClipedCallback)callback;

@end
