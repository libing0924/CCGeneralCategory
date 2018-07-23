//
//  UINavigationBar+LBExtend.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "UINavigationBar+LBExtend.h"

#import <objc/runtime.h>

const char* lb_navigationBar_hiddenKey = "lb_navigationBar_hiddenKey";

@implementation UINavigationBar (LBExtend)

static char overlayKey;

- (BOOL)lb_hidden {
    
    NSNumber *hidden = objc_getAssociatedObject(self, lb_navigationBar_hiddenKey);
    
    return hidden.boolValue;
}

- (void)setLb_hidden:(BOOL)lb_hidden {
    
    [self navigationBarHidden:lb_hidden];
    
    objc_setAssociatedObject(self, lb_navigationBar_hiddenKey, @(lb_hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lb_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;    // Should not set `UIViewAutoresizingFlexibleHeight` 自动调整overlay的宽度
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
        // 隐藏导航栏前景色
        self.lb_hidden = YES;
        
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)lb_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)lb_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)lb_reset
{
    
    self.lb_hidden = NO;
    self.overlay = nil;
    [self.overlay removeFromSuperview];
    
}

- (void) navigationBarHidden:(BOOL) hidden {
    
    if (hidden) {
        
        // 设置不同方向下的image对象，这么默认横竖屏都为一个image对象
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        // 隐藏的时候bar下面的黑线也隐藏
        self.shadowImage = [UIImage new];
        //        self.translucent = YES;
    } else {
        
        [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = nil;
        //        self.translucent = NO;
    }
}


@end
