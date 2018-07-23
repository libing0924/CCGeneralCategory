//
//  UIView+LBExtend.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

/**
 frame  (20, 20, 40, 40) 父视图参考系
 bounds (0, 0, 40, 40)   子视图参考系
 center (40, 40)
 position (40, 40)
 anchorPoint (0.5, 0.5) 只影响frame 比如这里为(0, 0) frame则变为(40, 40, 40, 40)其他属性不变
 相互之间关系
 */

#import <UIKit/UIKit.h>

/**动画类型*/
typedef NS_ENUM(NSUInteger, PPTransitionType) {
    /**向上翻一页*/
    PP_PageCurl = 1,
    /**向下翻一页*/
    PP_PageUnCurl,
    /**滴水效果*/
    PP_RippleEffect,
    /**收缩效果，如一块布被抽走*/
    PP_SuckEffect,
    /**立方体效果*/
    PP_Cube,
    /**上下翻转效果*/
    PP_OglFlip,
    /**打开相机的效果*/
    PP_Open,
    /**关闭相机的效果*/
    PP_Close,
    /**交叉淡化过渡*/
    PP_Fade,
    /**新视图移到旧视图上面*/
    PP_MoveIn,
    /**新视图把旧视图推出去*/
    PP_Push,
    /**将旧视图移开,显示下面的新视图*/
    PP_Reveal
    
};
/**动画方向*/
typedef NS_ENUM(NSUInteger, PPTransitionDirection) {
    PP_UP,
    PP_DOWN,
    PP_LEFT,
    PP_RIGHT
};

@interface UIView (LBExtend)

// 获取自己所在的视图控制器实例
@property (nonatomic, assign, readonly) UIViewController *lb_viewController;

/**快速返回size*/
@property (nonatomic, assign) CGSize lb_size;
/**快速返回宽度*/
@property (nonatomic, assign) CGFloat lb_width;
/**快速返回高度*/
@property (nonatomic, assign) CGFloat lb_height;
/**快速返回x*/
@property (nonatomic, assign) CGFloat lb_x;
/**快速返回y*/
@property (nonatomic, assign) CGFloat lb_y;

/**快速返回右边*/
@property (nonatomic, assign, readonly) CGFloat lb_rightX;
/**快速返回底部*/
@property (nonatomic, assign, readonly) CGFloat lb_bottomY;

// 锚点, layer的属性，通过设置锚点可改变view的形变参考系,暂未实现
/* Defines the anchor point of the layer's bounds rect, as a point in
 * normalized layer coordinates - '(0, 0)' is the bottom left corner of
 * the bounds rect, '(1, 1)' is the top right corner. Defaults to
 * '(0.5, 0.5)', i.e. the center of the bounds rect. Animatable. */
@property (nonatomic, assign) CGPoint lb_anchorPoint;
// 改变自身的参考中心点
// WARN 暂未实现 如旋转view依据的是view的中心点，以此可以改变旋转所依据的支点
@property (nonatomic, assign) CGPoint centerForSelf;

// 从xib创建实例
+(instancetype)viewFromXib;

// 判断与view是否相交
-(BOOL)intersectWithView:(UIView *)view;

// 添加动画
- (void)addTransitionAnimationWithDurection:(NSTimeInterval)durection anitionType:(PPTransitionType)type direction:(PPTransitionDirection)direction;

@end
