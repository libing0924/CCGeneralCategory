//
//  LBConfigureMacro.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/8.
//  Copyright © 2017年 李冰. All rights reserved.
//

#ifndef LBConfigureMacro_h
#define LBConfigureMacro_h

// 常用官方宏释
/**
 
 // 忽略警告
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Wincompatible-pointer-types"
 #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
 ...代码部分
 #pragma clang diagnostic pop
 
 // 断言
 NSAssert(<#condition#>, <#desc, ...#>)
 NSParameterAssert(<#condition#>)
 
 // 定义常量
 FOUNDATION_EXPORT
 
 // 内联函数，提升函数访问速度
 static inline function
 
 // 表明子类应继承的初始化函数来初始化
 NS_DESIGNATED_INITIALIZER
 
 // 废弃的属性/函数
 DEPRECATED_ATTRIBUTE
 
 // 宏if判断
 #ifdef
 ...执行代码
 #endif
 
 
 */

// 定义对应项目的主要字体、颜色等相关配置信息


一些建议的书写规范：

1.这样使用weak指针
__weak typeof(self) weakSelf = self;
myObj.myBlock = ^{
    __strong typeof(self) strongSelf = weakSelf;
    if (strongSelf) {
        [strongSelf doSomething]; // strongSelf != nil
        // preemption, strongSelf still not nil（抢占的时候，strongSelf 还是非 nil 的)
        [strongSelf doSomethingElse]; // strongSelf != nil }
        else { // Probably nothing... return;
        }
};
    
2.要求子类重写父类方法需要调用super的
// 注意:父类中的方法加`NS_REQUIRES_SUPER`,子类重写才有警告提示
- (void)prepare NS_REQUIRES_SUPER;
    
3.if语句尽量这样写
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return 44;
    if (indexPath.row == 1) return 80;
    if (indexPath.row == 2) return 50;
    return 44;
}

4.监听键盘的通知建议:
UIKIT_EXTERN NSString *const UIKeyboardWillChangeFrameNotification
而不是,下面代码;因为键盘可能因为改变输入法,切换成表情输入,切换成英文,那么frame可能会变高,变矮,不一定会发出下面这些通知,但是肯定会发上面的通知
    UIKIT_EXTERN?NSString *const UIKeyboardWillShowNotification;
    UIKIT_EXTERN?NSString *const UIKeyboardDidShowNotification;
    UIKIT_EXTERN?NSString *const UIKeyboardWillHideNotification;
    UIKIT_EXTERN?NSString *const UIKeyboardDidHideNotification;
    
5.从系统相册中取照片之前,应该判断系统相册是否可用,如果从相机中拍照获取,要判断相机是否可用
// 判断相册是否可以打开
if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;

// 判断相机是否可以打开
if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;

6.建议POST请求参数字典的写法,这样比较装逼~
// NSDictionaryOfVariableBindings这个宏生成一个字典,这个宏可以生成一个变量名到变量值映射的Dictionary,比如:
NSNumber * packId=@(2);
NSNumber *userId=@(22);
NSNumber *proxyType=@(2);
NSDictionary *param=NSDictionaryOfVariableBindings(packId,userId,proxyType);
    
#endif /* LBConfigureMacro_h */
