//
//  UIViewController+LBExtend.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LBExtend) <UIGestureRecognizerDelegate>

// 从storyBoard创建实例对象
+ (instancetype) lb_withStoryBoard;

// 保证自定义返回按钮右滑手势不失效
- (void) lb_respondSystemSlideGestureRecognizer;

// 实现整个屏幕右滑响应系统返回时间
- (void) lb_respondSystemSlideGestureRecognizerExtend;

@end
