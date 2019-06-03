//
//  ViewController.m
//  WGNativeAndJS
//
//  Created by wanggang on 2018/4/9.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import "ViewController.h"
#import "UIWebViewController.h"
#import "WKWebViewController.h"
#import "WGWKFirstViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBaseView];
}

- (void)setBaseView{
    for (int i = 0; i<3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100 + i * 50, 200, 30)];
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor yellowColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 10;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)btnClicked:(UIButton *)sender{
    if (sender.tag == 10) {
        WKWebViewController *wkweb = [[WKWebViewController alloc] init];
        [self.navigationController pushViewController:wkweb animated:YES];
    }else if (sender.tag == 11){
        
        WGWKFirstViewController *vc = [[WGWKFirstViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UIWebViewController * uiweb = [[UIWebViewController alloc] init];
        [self.navigationController pushViewController:uiweb animated:YES];
    }
}

-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSArray arrayWithObjects:@"WKWebview", @"WKWebview简单使用", @"UIWebview", nil];
    }
    return _titleArr;
}



@end
