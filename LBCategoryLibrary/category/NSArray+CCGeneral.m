//
//  NSArray+LBArray.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/7.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <objc/runtime.h>
#import "NSArray+CCGeneral.h"

@implementation NSArray (CCGeneral)

+ (void)load {
    
    
    // 这里使用dispatch_once_t保证SEL和IMP(函数指针)交换只进行一次，否则在子类调用父类方法时该方法可能会被执行两次，导致出现不可预知的错误
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(lb_objectAtIndex:));
        
        // 动态给类添加方法，如果lb_objectAtIndex:方法名已映射的函数指针IMP则添加失败，这里主要用来判断lb_objectAtIndex:函数名未被使用
        if (class_addMethod([self class], @selector(lb_objectAtIndex:), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {

            method_exchangeImplementations(fromMethod, toMethod);
        }

    });
}

/**
 *  这里进行容错处理，当下标越界时返回nil
 *  当[self objectAtIndex:index]时实际实际调用这里的方法实现
 */
- (id)cc_objectAtIndex:(NSUInteger)index {

    if (self.count-1 < index) {
        // 这里做一下异常处理，不然都不知道出错了。
        @try {
            return [self lb_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息，方便我们调试。
//            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
//            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {
            
        }
    } else {
        return [self lb_objectAtIndex:index]; // 这里实际调用的是objectAtIndex:方法实现
    }
}

@end
