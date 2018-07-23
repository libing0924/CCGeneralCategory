//
//  UIImage+QRCodeImage.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/30.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "UIImage+QRCodeImage.h"

@implementation UIImage (QRCodeImage)

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    UIImage *img = [UIImage imageWithCGImage:scaledImage];
    CGColorSpaceRelease(cs);
    CGContextRelease(bitmapRef);
    CGImageRelease(scaledImage);
    CGImageRelease(bitmapImage);
    
    return img;
}

+ (UIImage *)_QRCodeImageWithURLString:(NSString *)urlString withSize:(CGFloat)size {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setDefaults];
    NSString *dataString = urlString;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];
    
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
}

@end
