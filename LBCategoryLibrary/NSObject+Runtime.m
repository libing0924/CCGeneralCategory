//
//  NSObject+Runtime.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/6/20.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "NSObject+Runtime.h"

@implementation NSObject(Runtime)

- (NSArray *)selfProperty {
    
    NSMutableArray *namesArray = [NSMutableArray new];
    
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList([self class], &outCount);
    
    for (unsigned int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //属性名
        const char * name = property_getName(property);
        NSString *nameString = [NSString stringWithUTF8String:name];
        [namesArray addObject:nameString];
        //属性描述
        const char * propertyAttr = property_getAttributes(property);
        NSLog(@"属性描述为 %s 的 %s ", propertyAttr, name);
        
        //属性的特性
        unsigned int attrCount = 0;
        objc_property_attribute_t * attrs = property_copyAttributeList(property, &attrCount);
        for (unsigned int j = 0; j < attrCount; j ++) {
            objc_property_attribute_t attr = attrs[j];
            const char * name = attr.name;
            const char * value = attr.value;
            NSLog(@"属性的描述：%s 值：%s", name, value);
        }
        free(attrs);
        NSLog(@"\n");
    }
    free(properties);
    
    return namesArray.copy;
}

- (NSArray *)selfIvar {
    NSMutableArray *varArray = [NSMutableArray array];
    
    unsigned int methodCount = 0;
    Ivar * ivars = class_copyIvarList([self class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSLog(@"Person拥有的成员变量的类型为%s，名字为 %s ",type, name);
        [varArray addObject:[NSString stringWithUTF8String:name]];
    }
    free(ivars);
    
    return [varArray copy];
}

@end
