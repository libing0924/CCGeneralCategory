//
//  UIImage+LBImageCliped.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/7.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LBImageCliped)

#pragma mark - 边框相关属属性，仅对生成圆形图片和矩形图片有效
/**
 *	默认为1.0，当小于0时，不会添加边框，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, assign) CGFloat hyb_borderWidth;
/**
 *	当小于0时，不会添加边框。默认为0.仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, assign) CGFloat hyb_pathWidth;
/**
 *	边框线的颜色，默认为[UIColor lightGrayColor]，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor *hyb_borderColor;
/**
 *	Path颜色，默认为白色。仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor *hyb_pathColor;

#pragma mark - 放大或者缩小图片
/**
 *	将图片裁剪成指定大小，没有任何圆角，只是单纯的放大或者缩小图片，以降低内存的使用
 *
 *	@param targetSize 裁剪后的图片大小
 *  @param isEqualScale 是否是等比例缩放
 *
 *	@return 裁剪后的图片
 */
- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               isEqualScale:(BOOL)isEqualScale;

#pragma mark - 生成四个圆角图片
/**
 *	将图片裁剪成指定大小，可以指定四个圆角值，背景颜色（与控件的背景颜色一致可解决图层混合问题）
 *
 *	@param targetSize      裁剪后的图片大小
 *	@param cornerRadius		 图片的四个圆角值
 *	@param backgroundColor	背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *	@param isEqualScale			是否是等比例压缩
 *
 *	@return
 */
- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale;
/**
 * 生成带圆角图片，默认为白色背景、isEqualScale为YES
 */
- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius;

#pragma mark - 生成任意圆角的图片
/**
 *	生成带任意圆角的图片，可指定上、下、左、右
 *
 *	@param targetSize			  裁剪后的图片大小
 *	@param cornerRadius     圆角值，如果为0，表示不添加
 *	@param corners					指定哪些圆角，如果是左上、右上，可这样：UIRectCornerTopLeft | UIRectCornerTopRight
 *                          如果是全加圆角，使用UIRectCornerAllCorners
 *	@param backgroundColor  背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *	@param isEqualScale			是否是等比例压缩
 *
 *	@return 剪裁后的图片
 */
- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale;
/**
 * 生成任意带圆角的图片，默认为白色背景，isEqualScale=YES
 */
- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners;

#pragma mark - 生成圆形图片
/**
 *	将图片裁剪成圆形
 *
 *	@param targetSize			  裁剪后的图片大小.如果宽与高不相等，会通过isMax参数决定
 *	@param backgroundColor	背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *	@param isEqualScale			是否是等比例压缩
 *
 *	@return 圆形图片对象
 */
- (UIImage *)hyb_clipCircleToSize:(CGSize)targetSize
                  backgroundColor:(UIColor *)backgroundColor
                     isEqualScale:(BOOL)isEqualScale;
/**
 * 生成圆形图片，默认为白色背景、isEqualScale为YES
 */
- (UIImage *)hyb_clipCircleToSize:(CGSize)targetSize;


#pragma mark - 最完整的API
/**
 *	剪裁图片为任意指定圆角。isCircle的优化级最高，其次是cornerRadius，最后还是corners。
 *
 *	@param targetSize			  裁剪成指定的大小
 *	@param cornerRadius		  圆角大小
 *	@param corners					哪些圆角，多个圆角可用 | 来连接
 *	@param backgroundColor	背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *	@param isEqualScale     是否是等比例压缩
 *	@param isCircle					是否剪裁成圆。优化级最高。若为YES，生成的是圆形图片。
 *
 *	@return 剪裁后的图片
 */
- (UIImage *)hyb_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale
                   isCircle:(BOOL)isCircle;

@end
