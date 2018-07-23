//
//  UIImage+LBWithColor.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/7.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "UIImage+LBWithColor.h"

@implementation UIImage (LBWithColor)

+ (UIImage *)hyb_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius {
    return [self hyb_imageWithColor:color
                             toSize:targetSize
                       cornerRadius:cornerRadius
                    backgroundColor:[UIColor whiteColor]];
}

+ (UIImage *)hyb_imageWithColor:(UIColor *)color
                         toSize:(CGSize)targetSize
                   cornerRadius:(CGFloat)cornerRadius
                backgroundColor:(UIColor *)backgroundColor {
    UIGraphicsBeginImageContextWithOptions(targetSize, YES, [UIScreen mainScreen].scale);
    
    CGRect targetRect = (CGRect){0, 0, targetSize.width, targetSize.height};
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, targetRect);
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (cornerRadius != 0) {
        UIGraphicsBeginImageContextWithOptions(targetSize, YES, [UIScreen mainScreen].scale);
        
        if (backgroundColor) {
            [backgroundColor setFill];
            CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
        }
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
        CGContextClip(UIGraphicsGetCurrentContext());
        [finalImage drawInRect:targetRect];
        finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return finalImage;
}

+ (UIImage *)hyb_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize {
    return [self hyb_imageWithColor:color toSize:targetSize cornerRadius:0];
}

@end
