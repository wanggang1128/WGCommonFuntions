//
//  ViewController.m
//  WGNavigationGradualChange
//
//  Created by wanggang on 2018/7/31.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "WGNavigationView.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define TOP_HEIGHT (SCREEN_HEIGHT == 812.0 ? 88 : 64)

@interface ViewController ()<UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, WGNavigationViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WGNavigationView *navigationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ViewController";
    self.navigationController.delegate = self;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navigationView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}

#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.navigationView startAni:scrollView.contentOffset.y];
}

#pragma mark -UITableViewDelegate, UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 200;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FirstViewController *f = [[FirstViewController alloc] init];
    [self.navigationController pushViewController:f animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

#pragma mark -UINavigationControllerDelegate
// 将要显示控制器
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // 判断要显示的控制器是否是自己
    BOOL isShow = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShow animated:YES];
}

#pragma mark -WGNavigationViewDelegate
-(void)backBtnMethod{
    NSLog(@"backBtnMethod");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"backBtnMethod" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)actionBtnMethod{
    NSLog(@"actionBtnMethod");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"actionBtnMethod" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark -懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

-(WGNavigationView *)navigationView{
    if (!_navigationView) {
        _navigationView = [[WGNavigationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TOP_HEIGHT)];
        _navigationView.backgroundColor = UIColor.purpleColor;
        _navigationView.titleLab.text = @"标题";
        _navigationView.wgNavigationViewDelegate = self;
    }
    return _navigationView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"自定义导航栏不处理事件,事件的响应传递到这里");
}



@end
