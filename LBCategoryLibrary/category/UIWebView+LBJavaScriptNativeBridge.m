//
//  UIWebView+LBJavaScriptCallNative.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/14.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "UIWebView+LBJavaScriptNativeBridge.h"
#import <objc/runtime.h>

static const char * lb_web_AssociateMappingKey = "lb_web_AssociateMappingKey";

@implementation UIWebView (LBJavaScriptNativeBridge)

- (void)javaScriptFunctionName:(NSString *)funcName handler:(LBWebJavaScriptHandler)handler {

    JSContext *context = [self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    if (!self.handlerMapping) {
        
        self.handlerMapping = [[NSMutableDictionary alloc] init];
    }
    
    [self.handlerMapping setObject:[handler copy] forKey:funcName];
    
    [self addJavaScriptFunctionName:funcName andContext:context];
}

- (void) addJavaScriptFunctionName:(NSString *) funcName andContext:(JSContext *)context {

    context[funcName] = ^() {
        NSArray *arguments = [JSContext currentArguments];
        
        if ([self.handlerMapping objectForKey:funcName]) {
            
            LBWebJavaScriptHandler handler = [self.handlerMapping objectForKey:funcName];
            handler(arguments);
        }
        
    };
}

- (JSValue *)callWithJavaScriptFunctionName:(NSString *)funcName parameters:(NSArray <NSString *> *)parameters {

    NSParameterAssert(funcName);
    
    NSString *parametersStr = [parameters componentsJoinedByString:@","];
    
    NSString *jsStr = [[NSString alloc] initWithFormat:@"%@(%@)", funcName, parametersStr];
    
    // 1.webView调用JS的方法并传入参数
//    [self stringByEvaluatingJavaScriptFromString:jsStr];
    
    // 2.上下文执行JS方法
    JSContext *context=[self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    return [context evaluateScript:jsStr];
}

#pragma mark runtime

- (NSMutableDictionary *)handlerMapping {

    return objc_getAssociatedObject(self, lb_web_AssociateMappingKey);
}

- (void)setHandlerMapping:(NSMutableDictionary *)handlerMapping {

    objc_setAssociatedObject(self, lb_web_AssociateMappingKey, handlerMapping, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
