//
//  CALayer+LBBasicAnimation.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/23.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "CALayer+LBBasicAnimation.h"
#import <UIKit/UIKit.h>

@implementation CALayer (LBBasicAnimation)

- (void)lb_addAnimation:(CABasicAnimation *)animation {

    //set the from value (using presentation layer if available)
    animation.fromValue = [self.presentationLayer ?: self valueForKeyPath:animation.keyPath];
    //update the property in advance
    //note: this approach will only work if toValue != nil [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self setValue:animation.toValue forKeyPath:animation.keyPath]; [CATransaction commit];
    //apply animation to layer
    [self addAnimation:animation forKey:nil];
}

// example
//
//- (void)changeColor {
//    CALayer *layer = [[CALayer alloc] init];
//    layer.frame = CGRectMake(0, 0, 200, 200);
//    
//    //create a new random color
//    CGFloat red = arc4random() / (CGFloat)INT_MAX;
//    CGFloat green = arc4random() / (CGFloat)INT_MAX;
//    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//                      
//    //create a basic animation
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"backgroundColor";
//    animation.toValue = (__bridge id)color.CGColor;
//    //apply animation without snap-back
//    [layer lb_addAnimation:animation];
//}

@end
