//
//  NSArray+LBArray.h
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/7.
//  Copyright © 2017年 李冰. All rights reserved.
//

#if 0

 这里使用runtime的swizzling对NSArray下标越界进行容错处理，越界时返回一个nil

 每个类都有一个方法列表，存放着selector的名字和方法实现的映射关系。IMP有点类似函数指针，指向具体的Method实现。

 swizzling实际就是将SEL指向的IMP函数指针给交换了

 想要了解swizzling的使用可以查看 http://www.jianshu.com/p/ff19c04b34d0

#endif



#import <Foundation/Foundation.h>

@interface NSArray (LBArray)

@end
