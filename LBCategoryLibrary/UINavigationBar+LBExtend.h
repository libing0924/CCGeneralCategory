//
//  UINavigationBar+LBExtend.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

/**
 * 动态的设置UINavigationBar的一些属性
 *
 */

#import <UIKit/UIKit.h>

extern const char* lb_navigationBar_hiddenKey;

@interface UINavigationBar (LBExtend)

@property (nonatomic, assign) BOOL lb_hidden;

// 设置背景色
- (void)lb_setBackgroundColor:(UIColor *)backgroundColor;

// 设置子控件的透明度
- (void)lb_setElementsAlpha:(CGFloat)alpha;

// 设置偏移
- (void)lb_setTranslationY:(CGFloat)translationY;

// 移除所以本分类设置的效果
- (void)lb_reset;

@end
