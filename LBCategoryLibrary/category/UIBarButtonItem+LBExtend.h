//
//  UIBarButtonItem+LBExtend.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LBExtend)

+(UIBarButtonItem*)ItemWithBackGroundImage:(NSString*)image hilghtedBackGroundImage:(NSString*)hightImage target:(id)target action:(SEL)action;
+(UIBarButtonItem*)ItemWithBackGroundImage:(NSString*)image target:(id)target action:(SEL)action;

+(UIBarButtonItem*)ItemWithImage:(NSString*)image hilghtedImage:(NSString*)hightImage target:(id)target action:(SEL)action;

+(UIBarButtonItem *)ItemWithBtn:(UIButton *)btn;

+(UIBarButtonItem*)ItemWithImage:(NSString*)image selectedImage:(NSString*)selectedImage target:(id)target action:(SEL)action;

+(UIBarButtonItem *)ItemWithTitle:(NSString *)title target:(id)target action:(SEL)action color:(UIColor *)color;

@end
