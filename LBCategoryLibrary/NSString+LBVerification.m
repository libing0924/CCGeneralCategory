//
//  NSString+LBVerification.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/7.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "NSString+LBVerification.h"

@implementation NSString (LBVerification)


//检查是否只包含字母和数字
- (BOOL)isOnlyLeterAndNumber {
    
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
    
}

- (BOOL) isTelephoneNumber {
    
    if ([self length] == 0) {
        
        //        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"\n请您输入手机号", nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //        [alert show];
        return NO;
        
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    
    if (!isMatch) {
        
        return NO;
        
    }
    
    return YES;
    
}

#pragma mark - 检查有没有表情
- (BOOL)containsEmoji
{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

- (BOOL) isEmpty{
    
    if ([self isKindOfClass:[NSNull class]]) {
        return true;
    }
    
    
    if ([self isKindOfClass:[NSNumber class]]) { //如果是数字 //不能验证数字
        return false;
    }
    
    NSString *str;
    
    if (![self isKindOfClass:[NSString class]]) {
        str = [NSString stringWithFormat:@"%@",self];
    }else{
        str = self;
    }
    
    //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
    NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
    
    if ([trimedString length] == 0) {
        return true;
    }
    
    
    if( nil == str || (0 == str.length && ![str isEqualToString:@""]) ||[str.description isEqualToString:@"(null)"] ||[str isEqualToString:@""]){
        return true;
    }else{
        return false;
    }
    
}


- (id)JSONStringConvert;
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}


- (NSString *)checkAmountString {
    NSString *str;
    //处理数字格式
    if ([self rangeOfString:@"."].location != NSNotFound ) {
        //含小数点
        NSArray * sepArr = [self componentsSeparatedByString:@"."];
        str = sepArr[0];
        str = [str substringWithRange:NSMakeRange(str.length%3, str.length-str.length%3)];
        NSString *strs = [self substringWithRange:NSMakeRange(0, self.length%3)];
        for (int  i =0; i < str.length; i =i+3) {
            NSString *sss = [str substringWithRange:NSMakeRange(i, 3)];
            strs = [strs stringByAppendingString:[NSString stringWithFormat:@",%@",sss]];
        }
        if ([[strs substringWithRange:NSMakeRange(0, 1)] isEqualToString:@","]) {
            strs = [strs substringWithRange:NSMakeRange(1, strs.length-1)];
        }
        return [NSString stringWithFormat:@"%@.%@",strs,sepArr[1]];
    }else{
        //无小数点
        str = [self substringWithRange:NSMakeRange(self.length%3, self.length-self.length%3)];
        NSString *strs = [self substringWithRange:NSMakeRange(0, self.length%3)];
        for (int  i =0; i < str.length; i =i+3) {
            NSString *sss = [str substringWithRange:NSMakeRange(i, 3)];
            strs = [strs stringByAppendingString:[NSString stringWithFormat:@",%@",sss]];
        }
        if ([[strs substringWithRange:NSMakeRange(0, 1)] isEqualToString:@","]) {
            strs = [strs substringWithRange:NSMakeRange(1, strs.length-1)];
        }
        return strs;
    }
}

#pragma mark - 检查是否包含特殊字符串
- (BOOL) hasSpecialString {
    
    if (self.length <1) {
        return false;
    }
    
    //    int length = [[NSString stringWithFormat:@"%ld",[str length]]intValue];
    //
    //    NSMutableString *String = [[NSMutableString alloc]initWithString:str];
    //
    //    for(int i = length - 1; i >= 0; i--) {
    //        int a = [str characterAtIndex:i];
    //        if( a > 0x4e00 && a < 0x9fff){
    //
    //            [String replaceCharactersInRange:NSMakeRange(i,1) withString:@""];
    //        }
    //
    //    }
    //
    //    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    //    NSRange userNameRange = [String rangeOfCharacterFromSet:nameCharacters];
    //    if (userNameRange.location != NSNotFound) {
    //        NSLog(@"包含特殊字符");
    //        return true;
    //    }else{
    //        return false;
    //    }
    //    NSString *re = @"[~!/@#$%^&*()-=+\\|[{}]\'\"<>/?]+";
    //    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", re];
    //    return [pred evaluateWithObject:str];
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=）\\|~(＜＞$%^&*)_+？? "];
    NSRange range = [self rangeOfCharacterFromSet:doNotWant];
    
    return range.location < self.length;
}

#pragma mark - 判断字节长度
-(int)bytesLength {
    
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

#pragma mark - 检验邮箱
- (BOOL) isEmailAddress {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//MARK: 是否是汉字
- (BOOL)isChinese{
    NSString * re = @"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",re];
    return [pred evaluateWithObject:self];
}

@end
