//
//  NSObject+Runtime.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/6/20.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static inline void lb_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
//    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    BOOL didAddMethod =
    class_addMethod(theClass,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod(theClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static inline BOOL lb_addMethod(Class theClass, SEL selector, Method method) {
    return class_addMethod(theClass, selector,  method_getImplementation(method),  method_getTypeEncoding(method));
}

static inline BOOL lb_replaceMethod(Class theClass, SEL selector, Method method) {
    return class_replaceMethod(theClass, selector, method_getImplementation(method), method_getTypeEncoding(method));
}



@interface NSObject (Runtime)

- (NSArray *)selfProperty;
- (NSArray *)selfIvar;

@end
