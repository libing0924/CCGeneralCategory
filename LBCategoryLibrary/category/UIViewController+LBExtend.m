//
//  UIViewController+LBExtend.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "UIViewController+LBExtend.h"

@implementation UIViewController (LBExtend)

+(instancetype)lb_withStoryBoard {

    NSString *classStringHasPrefix = NSStringFromClass([self class]);
    NSArray *classStrings = [classStringHasPrefix componentsSeparatedByString:@"."];
    NSString *classString = classStrings.lastObject;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:classString bundle:nil];
    
    
    Class vc = NSClassFromString(classString);
    vc = (Class)[sb instantiateInitialViewController];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    return vc;
#pragma clang diagnostic pop
}

- (void)lb_respondSystemSlideGestureRecognizer {

    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void)lb_respondSystemSlideGestureRecognizerExtend {

//    setp1:需要获取系统自带滑动手势的target对象
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    
//    setp2:创建全屏滑动手势~调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    
//    step3:设置手势代理~拦截手势触发
    pan.delegate = self;
    
//    step4:别忘了~给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    
//    step5:将系统自带的滑动手势禁用
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

//steo6:还记得刚刚设置的代理吗？下面方法什么时候调用？在每次触发手势之前都会询问下代理，是否触发。
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{

    return YES;
}
//return NO;则不需要触发滑动手势
//return YES;则需要触发滑动手势

@end
