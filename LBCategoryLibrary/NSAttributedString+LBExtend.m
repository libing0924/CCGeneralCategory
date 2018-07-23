//
//  NSAttributedString+LBExtend.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/5/26.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "NSAttributedString+LBExtend.h"

@implementation NSAttributedString(LBExtend)

+(NSAttributedString *)withHTMLString:(NSString *)html {

    NSData * data = [html dataUsingEncoding:NSUTF32StringEncoding];
    
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc]initWithData:data options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    return attText;
}

@end
