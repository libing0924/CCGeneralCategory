//
//  UIImage+LBTransform.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LBTransform)


// 设置可拉伸空间 insets表示保护区域不会形变
//typedef NS_ENUM(NSInteger, UIImageResizingMode) {
//    UIImageResizingModeTile, // 平铺
//    UIImageResizingModeStretch, // 拉伸
//};
- (UIImage *) transformWithCapInsets:(UIEdgeInsets) insets resizingMode:(UIImageResizingMode) mode;

@end
