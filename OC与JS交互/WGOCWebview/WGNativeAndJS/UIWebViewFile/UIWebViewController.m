//
//  UIWebViewController.m
//  WGNativeAndJS
//
//  Created by wanggang on 2018/4/9.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import "UIWebViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface UIWebViewController ()

@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewView];
    [self setWebView];
}

- (void)setViewView{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setWebView{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    _webView.delegate = self;
    //从本地加载html文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"uiweb" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}

#pragma mark webview代理
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    // 设置javaScriptContext上下文
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //将wg对象指向自身
    self.jsContext[@"wg"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"异常信息：%@",exception);
    };
}

- (void)call{
    NSLog(@"call");
    // 之后在回调JavaScript的方法Callback把内容传出去
    JSValue *Callback = self.jsContext[@"Callback"];
    //传值给web端
    [Callback callWithArguments:@[@"ios->h5弹框"]];
}

- (void)getCall:(NSString *)callString{
    NSLog(@"Get:%@", callString);
    // 成功回调JavaScript的方法Callback
    JSValue *Callback = self.jsContext[@"alerCallback"];
    [Callback callWithArguments:@[callString]];
    
    //或者
    //    [self alert];
}

- (void)alert{
    // 直接添加提示框
    NSString *str = @"alert('OC添加JS提示成功')";
    [self.jsContext evaluateScript:str];
    
}

@end
