//
//  NSString+LBExtend.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "NSString+LBExtend.h"

@implementation NSString (LBExtend)

- (CGSize) sizeWithFont:(UIFont *) font {
    
    return [self sizeWithAttributes:@{NSFontAttributeName: font}];
}

- (CGRect)rectWithFont:(UIFont *)font {

    return [self rectWithFont:font width:CGFLOAT_MAX];
}

- (CGRect)rectWithFont:(UIFont *)font width:(CGFloat)width {

    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:\
                   NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName : font}
                                     context:nil];
    
    return rect;
}

- (NSString *)URLEncodedString:(NSString*)resource {
//    CFStringRef url = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)resource, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8); // for some reason, releasing this is disasterous
//    NSString *result = (__bridge NSString *)url;
    
    NSString *result = [resource stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //    [result autorelease];
    return result;
}

- (RangeFormatType)checkRange:(NSRange)range{
    NSInteger loc = range.location;
    NSInteger len = range.length;
    if (loc>=0 && len>0) {
        if (range.location + range.length <= self.length) {
            return RangeCorrect;
        }
        else{

            return RangeOut;
        }
    }
    else{

        return RangeError;
    }
}

+ (NSString *)subCharacterSetWithCharactersInString:(NSString *)string willDeleteStr:(NSString *)str{
    NSString *tempString = string;
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:str];
    
    tempString = [[tempString componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    return tempString;
    
}
+ (NSString *)subCharacterSetWithCharactersInString:(NSString *)string willDeleteStr:(NSString *)str replace:(NSString *)st{
    NSString *tempString = string;
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:str];
    
    tempString = [[tempString componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: st];
    return tempString;
    
}

- (NSMutableAttributedString *)changeColor:(UIColor *)color
                                  range:(NSRange)range{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if ([self checkRange:range] == RangeCorrect) {
        if (color) {
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
        else{
            return nil;
        }
        
    }
    return attributedStr;
}


- (NSMutableAttributedString *)changeFont:(UIFont *)font
                                 range:(NSRange)range{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if ([self checkRange:range] == RangeCorrect) {
        if (font) {
            [attributedStr addAttribute:NSFontAttributeName value:font range:range];
        }
        else{
            return nil;
        }
    }
    return attributedStr;
}

- (NSMutableAttributedString *)changeColor:(UIColor *)color
                                 colorRang:(NSRange)colorRange
                                   andFont:(UIFont *)font
                                 fontRange:(NSRange)fontRange{
    
    NSMutableAttributedString *attrStr = [self changeColor:color range:colorRange];
    
    if (!attrStr || !font) {
        
        return nil;
    }
    
    if ([self checkRange:fontRange] == RangeCorrect) {

        [attrStr addAttribute:NSFontAttributeName value:font range:fontRange];

    }
    return attrStr;
}

- (NSMutableAttributedString *)changeColor:(UIColor *)color
                                    ranges:(NSArray<NSValue *> *)ranges {
    
    if (!color) {
        
        return nil;
    }
    
    __block NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];

    [ranges enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [(NSValue *)obj rangeValue];
        if ([self checkRange:range] == RangeCorrect) {
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
    }];


    return attributedStr;
}

- (NSMutableAttributedString *)changeFont:(UIFont *)font
                                   ranges:(NSArray<NSValue *> *)ranges {
    
    if (!font) {
        
        return nil;
    }
    
    __block NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];

    [ranges enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [(NSValue *)obj rangeValue];
        if ([self checkRange:range] == RangeCorrect) {
            [attributedStr addAttribute:NSFontAttributeName value:font range:range];
        }
    }];

    return attributedStr;
}

- (NSMutableAttributedString *)lineSpacing:(NSInteger)lineSpacing
{
    
    NSMutableAttributedString * textAttr = [[NSMutableAttributedString alloc]initWithString:self];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpacing];
    
    [textAttr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    
    return textAttr;
    
}

@end
