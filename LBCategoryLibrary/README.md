# 李冰 category维护表
===========

简书: www.jianshu.com/u/315550795c00

pod install --verbose --no-repo-update

##

类别中对响应的库整理如下

类别文件                    作用                                  使用相关库的函数
    
NSArray+LBArray           数组容错处理                            runtime的swizzling

UIView+LBViewCliped       UIView添加切圆角                        runtime的objc_setAssociatedObject
                          设置UIView的寄宿图                      runtime的objc_getAssociatedObject
                          (可见iOS Core Animation书中的第二章)     QuartzCore

UIImage+LBImageCliped     UIImage切圆角                          runtime的objc_setAssociatedObject
                                                                runtime的objc_getAssociatedObject
                                                                QuartzCore

UIImage+LBWithColor       根据色彩空间创建UIImage对象               QuartzCore

NSString+LBVerification   校验NSString关键信息
