//
//  UIImage+QRCodeImage.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/30.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CCQRCode)

// 根据字符串和size创建UIImage二维码图片对象
+ (UIImage *)imageWithURLString:(NSString *)urlString withSize:(CGFloat)size;

@end
