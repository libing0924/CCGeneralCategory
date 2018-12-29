//
//  UILabel+LBExtend.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "UILabel+CCGeneral.h"

@implementation UILabel (CCGeneral)

- (CGFloat)lb_textWidth {

//    CGFloat width = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
    CGFloat width = [self labelSizeWithMaxWidth:CGFLOAT_MAX textFont:self.font].width;
    return width;
}

- (CGFloat)lb_textHeight {

//    CGFloat height = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].height;
    CGFloat height = [self labelSizeWithMaxWidth:CGFLOAT_MAX textFont:self.font].height;
    return height;
}

- (CGSize) labelSizeWithMaxWidth:(CGFloat)width textFont:(UIFont *)font{
    
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                          options:\
                   NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName: font}
                                          context:nil];
    
    return rect.size;
}

/**
 font:14
 color:323232
 
 @return label
 */
+ (instancetype) defaultBlackMediumLabel {

    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:50.0 / 255.0f  green:50.0 / 255.0f blue:50.0 / 255.0f alpha:1];
    label.font = [UIFont systemFontOfSize:14];
    
    return label;
}

/**
 font:12
 color:323232
 
 @return label
 */
+ (instancetype) defaultBlackLittleLabel {
 
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:50.0 / 255.0f  green:50.0 / 255.0f blue:50.0 / 255.0f alpha:1];
    label.font = [UIFont systemFontOfSize:12];
    
    return label;
}

/**
 font:10
 color:323232
 
 @return label
 */
+ (instancetype) defaultBlackMinimumLabel {

    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:50.0 / 255.0f  green:50.0 / 255.0f blue:50.0 / 255.0f alpha:1];
    label.font = [UIFont systemFontOfSize:10];
    
    return label;
}

/**
 font:14
 color:969696
 
 @return label
 */
+ (instancetype) defaultGrayMediumLabel {

    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:150.0 / 255.0f  green:150.0 / 255.0f blue:150.0 / 255.0f alpha:1];
    label.font = [UIFont systemFontOfSize:14];
    
    return label;
}

/**
 font:12
 color:969696
 
 @return label
 */
+ (instancetype) defaultGrayLittleLabel {

    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:150.0 / 255.0f  green:150.0 / 255.0f blue:150.0 / 255.0f alpha:1];
    label.font = [UIFont systemFontOfSize:12];
    
    return label;
}

/**
 font:10
 color:969696
 
 @return label
 */
+ (instancetype) defaultGrayMinimumLabel {

    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:150.0 / 255.0f  green:150.0 / 255.0f blue:150.0 / 255.0f alpha:1];
    label.font = [UIFont systemFontOfSize:10];
    
    return label;
}

@end
