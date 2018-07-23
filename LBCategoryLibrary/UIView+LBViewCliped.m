//
//  UIView+LBViewCliped.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/7.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+LBViewCliped.h"

#import "UIImage+LBImageCliped.h"

static const char *lb_image_borderColorKey = "lb_image_borderColorKey";
static const char *lb_image_borderWidthKey = "lb_image_borderWidthKey";
static const char *lb_image_pathColorKey = "lb_image_pathColorKey";
static const char *lb_image_pathWidthKey = "lb_image_pathWidthKey";

@implementation UIView (LBViewCliped)

- (void)lb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize {

    CGRect frame = CGRectMake(0, 0, targetSize.width, targetSize.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame
                                               byRoundingCorners:corner
                                                     cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = frame;
    layer.path = path.CGPath;
    
    self.layer.mask = layer;
}

- (void)lb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)radius {

    [self lb_addCorner:corner
          cornerRadius:radius
                  size:self.bounds.size];
}

- (void)lb_addCornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize {

    [self lb_addCorner:UIRectCornerAllCorners
          cornerRadius:cornerRadius
                  size:targetSize];
}

- (void)lb_addCornerRadius:(CGFloat)radius {

    [self lb_addCorner:UIRectCornerAllCorners
          cornerRadius:radius
                  size:self.bounds.size];
}

#pragma mark - image

- (UIImage *)hyb_setImage:(id)image size:(CGSize)targetSize isEqualScale:(BOOL)isEqualScale onCliped:(HYBClipedCallback)callback {
    return [self hyb_private_setImage:image
                                 size:targetSize
                         cornerRadius:0
                          rectCorener:UIRectCornerAllCorners
                      backgroundColor:nil
                         isEqualScale:isEqualScale
                             isCircle:NO
                             onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image isEqualScale:(BOOL)isEqualScale onCliped:(HYBClipedCallback)callback {
    return [self hyb_setImage:image size:self.frame.size isEqualScale:isEqualScale onCliped:callback];
}

- (UIImage *)hyb_setCircleImage:(id)image
                           size:(CGSize)targetSize
                   isEqualScale:(BOOL)isEqualScale
                 backgrounColor:(UIColor *)backgroundColor
                       onCliped:(HYBClipedCallback)callback {
    return [self hyb_private_setImage:image
                                 size:targetSize
                         cornerRadius:0
                          rectCorener:UIRectCornerAllCorners
                      backgroundColor:backgroundColor
                         isEqualScale:isEqualScale
                             isCircle:YES
                             onCliped:callback];
}

- (UIImage *)hyb_setCircleImage:(id)image size:(CGSize)targetSize isEqualScale:(BOOL)isEqualScale onCliped:(HYBClipedCallback)callback {
    return [self hyb_private_setImage:image
                                 size:targetSize
                         cornerRadius:0
                          rectCorener:UIRectCornerAllCorners
                      backgroundColor:[UIColor whiteColor]
                         isEqualScale:isEqualScale
                             isCircle:YES
                             onCliped:callback];
}

- (UIImage *)hyb_setCircleImage:(id)image isEqualScale:(BOOL)isEqualScale onCliped:(HYBClipedCallback)callback {
    return [self hyb_setCircleImage:image size:self.frame.size isEqualScale:isEqualScale onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
          backgroundColor:(UIColor *)backgroundColor
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(HYBClipedCallback)callback {
    return [self hyb_setImage:image
                         size:targetSize
                 cornerRadius:cornerRaidus
                   rectCorner:UIRectCornerAllCorners
              backgroundColor:backgroundColor
                 isEqualScale:isEqualScale
                     onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
                 onCliped:(HYBClipedCallback)callback {
    return [self hyb_setImage:image
                         size:targetSize
                 cornerRadius:cornerRaidus
              backgroundColor:[UIColor whiteColor]
                 isEqualScale:YES
                     onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus onCliped:(HYBClipedCallback)callback {
    return [self hyb_setImage:image size:self.frame.size cornerRadius:cornerRaidus onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
          backgroundColor:(UIColor *)backgroundColor
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(HYBClipedCallback)callback {
    return [self hyb_private_setImage:image
                                 size:targetSize
                         cornerRadius:cornerRaidus
                          rectCorener:rectCorner
                      backgroundColor:backgroundColor
                         isEqualScale:isEqualScale
                             isCircle:NO
                             onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(HYBClipedCallback)callback {
    return [self hyb_private_setImage:image
                                 size:self.frame.size
                         cornerRadius:cornerRaidus
                          rectCorener:rectCorner
                      backgroundColor:[UIColor whiteColor]
                         isEqualScale:isEqualScale
                             isCircle:NO
                             onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
                 onCliped:(HYBClipedCallback)callback {
    return [self hyb_setImage:image
                         size:targetSize
                 cornerRadius:cornerRaidus
                   rectCorner:rectCorner
              backgroundColor:[UIColor whiteColor]
                 isEqualScale:YES
                     onCliped:callback];
}

- (UIImage *)hyb_setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
                 onCliped:(HYBClipedCallback)callback {
    return [self hyb_setImage:image
                         size:self.frame.size
                 cornerRadius:cornerRaidus
                   rectCorner:rectCorner
                     onCliped:callback];
}

#pragma makr - Private
- (UIImage *)hyb_private_setImage:(id)image
                             size:(CGSize)targetSize
                     cornerRadius:(CGFloat)cornerRadius
                      rectCorener:(UIRectCorner)rectCorner
                  backgroundColor:(UIColor *)bgColor
                     isEqualScale:(BOOL)isEqualScale
                         isCircle:(BOOL)isCircle
                         onCliped:(HYBClipedCallback)callback {
    if (image == nil) {
        return nil;
    }
    
    UIImage *willBeClipedImage = image;
    if ([image isKindOfClass:[NSString class]]) {
        willBeClipedImage = [UIImage imageNamed:image];
    } else if ([image isKindOfClass:[UIImage class]]) {
        willBeClipedImage = image;
    } else if ([image isKindOfClass:[NSData class]]) {
        willBeClipedImage = [UIImage imageWithData:image];
    }
    
    if (willBeClipedImage == nil) {
        return nil;
    }
    
    __block UIImage *clipedImage = nil;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        willBeClipedImage.hyb_pathColor = self.lb_pathColor;
        willBeClipedImage.hyb_pathWidth = self.lb_pathWidth;
        willBeClipedImage.hyb_borderColor = self.lb_borderColor;
        willBeClipedImage.hyb_borderWidth = self.lb_borderWidth;
        
        clipedImage = [willBeClipedImage hyb_clipToSize:targetSize
                                           cornerRadius:cornerRadius
                                                corners:rectCorner
                                        backgroundColor:bgColor
                                           isEqualScale:isEqualScale
                                               isCircle:isCircle];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (clipedImage) {
                if ([self isKindOfClass:[UIImageView class]]) {
                    UIImageView *imgView = (UIImageView *)self;
                    imgView.image = clipedImage;
                } else if ([self isKindOfClass:[UIButton class]]) {
                    UIButton *button = (UIButton *)self;
                    [button setImage:clipedImage forState:UIControlStateNormal];
                } else {
                    self.layer.contents = (__bridge id _Nullable)(clipedImage.CGImage);
                }
                
                if (callback) {
                    callback(clipedImage);
                }
            }
        });
    });
    
    return willBeClipedImage;
}

#pragma mark - Border
- (CGFloat)lb_borderWidth {
    NSNumber *borderWidth = objc_getAssociatedObject(self, lb_image_borderWidthKey);
    
    if ([borderWidth respondsToSelector:@selector(doubleValue)]) {
        return borderWidth.doubleValue;
    }
    
    return 1;
}

- (void)setLb_borderWidth:(CGFloat)hyb_borderWidth {
    objc_setAssociatedObject(self,
                             lb_image_borderWidthKey,
                             @(hyb_borderWidth),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)lb_pathWidth {
    NSNumber *width = objc_getAssociatedObject(self, lb_image_pathWidthKey);
    
    if ([width respondsToSelector:@selector(doubleValue)]) {
        return width.doubleValue;
    }
    
    return 0;
}

- (void)setLb_pathWidth:(CGFloat)hyb_pathWidth {
    objc_setAssociatedObject(self,
                             lb_image_pathWidthKey,
                             @(hyb_pathWidth),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)lb_pathColor {
    UIColor *color = objc_getAssociatedObject(self, lb_image_pathColorKey);
    
    if (color) {
        return color;
    }
    
    return [UIColor whiteColor];
}

- (void)setLb_pathColor:(UIColor *)hyb_pathColor {
    objc_setAssociatedObject(self,
                             lb_image_pathColorKey,
                             hyb_pathColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIColor *)lb_borderColor {
    UIColor *color = objc_getAssociatedObject(self, lb_image_borderColorKey);
    
    if (color) {
        return color;
    }
    
    return [UIColor lightGrayColor];
}

- (void)setLb_borderColor:(UIColor *)hyb_borderColor {
    objc_setAssociatedObject(self,
                             lb_image_borderColorKey,
                             hyb_borderColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
