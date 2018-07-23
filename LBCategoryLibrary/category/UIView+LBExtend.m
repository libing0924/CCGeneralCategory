//
//  UIView+LBExtend.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "UIView+LBExtend.h"

@implementation UIView (LBExtend)

- (UIViewController *)lb_viewController {

    if ([self.nextResponder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)self.nextResponder;
    }
    if (self.superview == nil) {
        NSAssert(NO, @"此控件没有父控件");
    }
    return self.superview.lb_viewController;
}

- (CGSize)lb_size {

    return self.frame.size;
}

- (void)setLb_size:(CGSize)lb_size {

    self.frame = CGRectMake(self.lb_x, self.lb_y, lb_size.width, lb_size.height);
}

- (CGFloat)lb_width {

    return self.lb_size.width;
}

- (void)setLb_width:(CGFloat)lb_width {

    self.frame = CGRectMake(self.lb_x, self.lb_y, lb_width, self.lb_height);
}

- (CGFloat)lb_height {

    return self.lb_size.height;
}

- (void)setLb_height:(CGFloat)lb_height {

    self.frame = CGRectMake(self.lb_x, self.lb_y, self.lb_width, lb_height);
}

- (CGFloat)lb_x {

    return self.frame.origin.x;
}

- (void)setLb_x:(CGFloat)lb_x {

    self.frame = CGRectMake(lb_x, self.lb_y, self.lb_width, self.lb_height);
}

- (CGFloat)lb_y {

    return self.frame.origin.y;
}

- (void)setLb_y:(CGFloat)lb_y {

    self.frame = CGRectMake(self.lb_x, lb_y, self.lb_width, self.lb_height);
}

- (CGFloat)lb_rightX {

    return CGRectGetMaxX(self.frame);
}

- (CGFloat)lb_bottomY {

    return CGRectGetMaxY(self.frame);
}

+(instancetype)viewFromXib{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
}

-(BOOL)intersectWithView:(UIView *)view{
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (void)addTransitionAnimationWithDurection:(NSTimeInterval)durection anitionType:(PPTransitionType)type direction:(PPTransitionDirection)direction{
    
    //1.创建动画对象
    CATransition * trAnimation = [CATransition animation];
    
    //2.设置动画时间
    trAnimation.duration = durection;
    
    //3.设置动画类型
    NSArray * typeArray = @[@"pageCurl",@"pageUnCurl",@"rippleEffect",@"suckEffect",@"cube",@"oglFlip", @"cameraIrisHollowOpen", @"cameraIrisHollowClose ", kCATransitionFade,kCATransitionMoveIn, kCATransitionPush,kCATransitionReveal];
    [trAnimation setType:typeArray[type]];
    
    //4.设置方向
    NSArray * directionArray = @[@"fromUp",@"fromDown",@"fromLeft", @"fromRight"];
    [trAnimation setSubtype:directionArray[direction]];
    
    //5.添加动画
    [self.layer addAnimation:trAnimation forKey:@"aa"];
    
    
}

- (void)setCenterForSelf:(CGPoint)centerForSelf {

    self.layer.anchorPoint = centerForSelf;
}

- (void)setLb_anchorPoint:(CGPoint)lb_anchorPoint {

    self.layer.anchorPoint = lb_anchorPoint;
}

@end
