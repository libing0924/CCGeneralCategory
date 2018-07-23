//
//  LBCommonMacro.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#ifndef LBCommonMacro_h
#define LBCommonMacro_h

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d  \t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//NSLog(...) NSLog(__VA_ARGS__);
//#define LOG_METHOD NSLog(@"%s", __func__);
#else
#define NSLog(...) ;
//#define LOG_METHOD ;
#endif

// ================== 宏定义变量名 ===================
// int varName(a) = 2 -> int vara = 2
#define VarName(n) var##n

// ================== 将变量名转对应的字符串 ===========
// int test = 1;
// varNameToString(test) -> test
// 可见系统定义的宏NSDictionaryOfVariableBindings(...)
#define VarNameToString(...) @"" # __VA_ARGS__

// =============== 日志 ===============
#ifdef DEBUG
#define LBLog(FORMAT, ...) fprintf(stderr,"%s:%d  \t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//NSLog(...) NSLog(__VA_ARGS__);
//#define LOG_METHOD NSLog(@"%s", __func__);

#define XCODE_COLORS_ESCAPE_MAC @"\033["
#define XCODE_COLORS_ESCAPE_IOS @"\xC2\xA0["
#define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_MAC
#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color
#define LLogBlue(frmt, ...) NSLog((@"%s [Line: %d] ----- > : " XCODE_COLORS_ESCAPE @"fg0,150,255;" frmt XCODE_COLORS_RESET),[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, ##__VA_ARGS__)

#else
#define LBLog(...) ;
#define LLogBlue(frmt, ...)
//#define LOG_METHOD ;
#endif

// ===================== 弱指针 =====================
#define LBWeakSelf(type) __weak typeof(type) weak##type = type
#define WEAKSELF typeof(self) __weak weakSelf = self;
// ===================== 链接字符串 =================== LBConnectString(我是字符串)
#define LBConnectString(str) [NSString stringWithFormat:@"%@", @#str]

// ===================== 系统相关 =====================
#define APP_DELEGATE() ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == 568.0)
#define IS_IOS_7 (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) ? YES : NO)
#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] >= 7)
#define IsIOS8 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] >= 8.0)
#define IsIOS9 (([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] >= 9.0) && [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]<10.0)
#define IsIOS10 ([[[UIDevice currentDevice] systemVersion] compare:@"10" options:NSNumericSearch] != NSOrderedAscending)

// ==================== App Version ====================
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define AppBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

// ===================== 尺寸相关 =====================
/** 屏幕尺寸*/
#define lbScreenSize [UIScreen mainScreen].bounds.size

#define lbScreenWidth lbScreenSize.width
#define lbScreenHeight lbScreenSize.height

#define lbFont(fSize) [UIFont systemFontOfSize:(fSize)]
#define adaptationFont(fSize) [UIFont systemFontOfSize:AdaptationRatioW(fSize)]

// 不同手机适配比例
#define AdaptationRatioH(h) (lbScreenSize.height / 667)* h
#define AdaptationRatioW(w) (lbScreenSize.width / 375)* w
// 不同手机适配比例
#define AdaptationRatio(w) (SCREEN_WIDTH / 375.0f)* w

/** 状态栏高度*/
#define  lbStatusBarHeight ([[UIScreen mainScreen] bounds].size.height == 812.0f ? 44.0f : 20.f)
/** 导航栏高度*/
#define  lbNavigationBarHeight 44.f
/** 标签栏高度*/
#define  lbTabbarHeight 49.f
/** 底部安全区域*/
#define  lbBottomSafeHeight ([[UIScreen mainScreen] bounds].size.height == 812.0f ? 34.0f : 00.f)
/** 大标题高度*/
#define lbLargeTitleHeight 52.0f;

// ===================== 设备App相关===================
// app名称
#define App_Name [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
// app版本
#define App_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// app build版本
#define App_Build [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

//手机序列号
#define Device_UUID [[UIDevice currentDevice].identifierForVendor UUIDString]
//手机别名 my iPhone
#define Device_PhoneName [[UIDevice currentDevice] name]
//设备名称 iOS
#define Device_SystemName [[UIDevice currentDevice] systemName]
//手机系统版本 iOS 10.0
#define Device_SystemVersion [[UIDevice currentDevice] systemVersion]
//手机型号 iPhone iPod
#define Device_PlatformModel [[UIDevice currentDevice] model]
//地方型号  （国际化区域名称）
#define Device_LocalModel [[UIDevice currentDevice] localizedModel]

/** documentPath */
#define DocumentPath  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject

/** cachesPath */
#define CachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]

/** librabyPath */
#define LibraryPath [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject]

/** tmpPath */
#define TmpPath NSTemporaryDirectory()

// 角度弧度互转 M_PI = 180°
// 弧度 -> 角度
#define RADIANS_TO_DEGREES(x) ((x)/M_PI*180.0) 
// 角度 -> 弧度
#define DEGREES_TO_RADIANS(x) ((x)/180.0*M_PI)

#define Block_copy(...) ((__typeof(__VA_ARGS__))_Block_copy((const void *)(__VA_ARGS__)))
#define Block_release(...) _Block_release((const void *)(__VA_ARGS__))

#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

// round() 四舍五入 floor向下取整 ceil向上取整


// 指定继承父类
#ifndef LB_REQUIRES_SUPER
#if __has_attribute(objc_requires_super)
#define LB_REQUIRES_SUPER __attribute__((objc_requires_super))
#else
#define LB_REQUIRES_SUPER
#endif
#endif

// 适配iOS11 vc.automaticallyAdjustsScrollViewInsets属性作废
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

// 业务逻辑相关
// 分页码
#define PAGE_INDEX 1
// 分页大小
#define PAGE_SIZE 10

#endif /* LBCommonMacro_h */
