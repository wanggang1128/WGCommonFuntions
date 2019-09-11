//
//  FirstViewController.m
//  ZCTopAnimationView
//
//  Created by wanggang on 2018/7/31.
//  Copyright © 2018年 张闯闯. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FirstViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavBarAppearance:YES];
}

- (void)setNavBarAppearance:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor redColor];
//    navBar.barTintColor = UIColor.yellowColor;
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = YES;
    
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName : [UIColor purpleColor],
                          NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:25]
                          };
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
