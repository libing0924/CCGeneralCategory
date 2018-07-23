//
//  UIImage+LBTransform.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "UIImage+LBTransform.h"

@implementation UIImage (LBTransform)

- (UIImage *)transformWithCapInsets:(UIEdgeInsets)insets resizingMode:(UIImageResizingMode)mode {

    return [self resizableImageWithCapInsets:insets resizingMode:mode];
}

@end
