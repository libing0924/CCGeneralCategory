//
//  UIWebView+LBJavaScriptCallNative.h
//  LBCategoryLibrary
//
//  Created by smufs on 2015/3/14.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

// JS句柄
typedef void(^LBWebJavaScriptHandler)(id parameter);

@interface UIWebView (LBJavaScriptNativeBridge)

// js函数名 -> handler映射表
@property (nonatomic, strong) NSMutableDictionary *handlerMapping;

/**
 * @abstract JavaScriptCore中javaScript函数调用OC方法，
 * @param funcName JavaScript中的函数名
 * @param handler OC函数体
 * @discussion JavaScriptCore中javaScript函数调用OC方法，
 */

- (void) javaScriptFunctionName:(NSString *) funcName handler:(LBWebJavaScriptHandler) handler;

/**
 * @abstract OC调用JavaScript方法
 * @param funcName JavaScript中的函数名
 * @param parameters 传给JavaScript函数的参数，一定要按照参数顺序存进数组
 * @discussion OC调用JavaScript方法
 */

- (JSValue *) callWithJavaScriptFunctionName:(NSString *) funcName parameters:(NSArray <NSString *> *) parameters;

@end
