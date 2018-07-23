//
//  UIImagePickerController+LBExtend.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/13.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "UIImagePickerController+LBExtend.h"

@implementation UIImagePickerController (LBExtend)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 一下是预设vc的样式，当导入该类别的时候，会自动使用一下样式去预设vc
// 使强制横屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskLandscape;
}

// 状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

// 状态栏显示
- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
