//
//  ViewController.m
//  LBCategoryLibrary
//
//  Created by smufs on 2017/3/7.
//  Copyright © 2017年 李冰. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+LBExtend.h"

#define NAVBAR_CHANGE_POINT 50

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.view.backgroundColor = [UIColor grayColor];

    UIButton *hidd = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 50, 50)];
    [hidd setTitle:@"隐藏" forState:UIControlStateNormal];
    [hidd addTarget:self action:@selector(hiddenAction:) forControlEvents:UIControlEventTouchDown];
    [hidd setBackgroundColor:[UIColor redColor]];
    
    
    UITableView *tab = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tab];
    tab.delegate = self;
    tab.dataSource = self;
    tab.rowHeight = 50;
    
    [self.view addSubview:hidd];
    
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    view1.backgroundColor = [UIColor redColor];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    view2.backgroundColor = [UIColor blueColor];
//    [view1 addSubview:view2];
//    view1.layer.masksToBounds = YES;
    [view2 setTransform:CGAffineTransformMakeRotation(M_PI_4)];
    NSLog(@"%@ %@", NSStringFromCGRect(view2.frame), NSStringFromCGRect(view2.bounds));
    
    view1.layer.anchorPoint = CGPointMake(0, -0.5);
    NSLog(@"%@ %@", NSStringFromCGRect(view1.frame), NSStringFromCGRect(view1.bounds));
//    [view1 setTransform:CGAffineTransformMakeRotation(M_PI_4)];
    static CGFloat x = M_PI_4 / 2.0f;
    [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
       
        [view1 setTransform:CGAffineTransformMakeRotation(x++)];
    }];
    
    [self.view addSubview:view1];
    
}

- (void) hiddenAction:(UIButton *) sender {

    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [sender setTitle:@"显示" forState:UIControlStateNormal];
        self.navigationController.navigationBar.lb_hidden = YES;
    } else {
        [sender setTitle:@"隐藏" forState:UIControlStateNormal];
        self.navigationController.navigationBar.lb_hidden = NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *ce = [tableView dequeueReusableCellWithIdentifier:@"qq"];
    
    if (!ce) {
        
        ce = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"qq"];
    }
    
    return ce;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {

        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > NAVBAR_CHANGE_POINT) {
            CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
            [self.navigationController.navigationBar lb_setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:alpha]];
        } else {
            [self.navigationController.navigationBar lb_setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0]];
        }
    
}


@end
