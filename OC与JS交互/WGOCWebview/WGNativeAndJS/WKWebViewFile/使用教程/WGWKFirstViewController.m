//
//  WGWKFirstViewController.m
//  WGNativeAndJS
//
//  Created by wanggang on 2019/6/3.
//  Copyright © 2019 wanggang. All rights reserved.
//

#import "WGWKFirstViewController.h"
#import <WebKit/WebKit.h>

@interface WGWKFirstViewController ()<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *wkWebview;
@property (nonatomic, strong) CALayer *processLayer;

@end

@implementation WGWKFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WKWebview使用";
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.selectionGranularity = WKSelectionGranularityDynamic;
    config.allowsInlineMediaPlayback = YES;
    WKUserContentController *user = [[WKUserContentController alloc] init];
    [user addScriptMessageHandler:self name:@"wg"];
    config.userContentController = user;
    
    WKPreferences *preference = [[WKPreferences alloc] init];
    preference.javaScriptEnabled = YES;
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    
    config.preferences = preference;
    self.wkWebview = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
    [_wkWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jianshu.com/u/c9dfc3858121"]]];
//    NSString *webViewURLStr = [[NSBundle mainBundle] pathForResource:@"wkweb.html" ofType:nil];
//    NSURL *fileURL = [NSURL fileURLWithPath:webViewURLStr];
//    [_wkWebview loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    _wkWebview.UIDelegate = self;
    _wkWebview.navigationDelegate = self;
    [_wkWebview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_wkWebview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_wkWebview];
    
    self.processLayer = [CALayer layer];
    _processLayer.frame = CGRectMake(0, 64, 0, 3);
    _processLayer.backgroundColor = UIColor.greenColor.CGColor;
    [self.view.layer addSublayer:_processLayer];
    
}

#pragma mark - WKScriptMessageHandler
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
}

#pragma mark - WKNavigationDelegate
//页面开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    NSLog(@"---->页面开始加载:%@",navigation);
}
//开始返回内容
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"---->开始返回内容:%@",navigation);
}
//页面加载完成
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"---->页面加载完成:%@",navigation);
}
//页面加载失败
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"---->页面加载失败:%@",navigation);
}
//在发送请求之前，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
     NSLog(@"---->在发送请求之前，决定是否跳转:%@",navigationAction.request.mainDocumentURL);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
//    decisionHandler(WKNavigationActionPolicyCancel);
}

//在收到响应后，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"---->在收到响应后，决定是否跳转:%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
//    decisionHandler(WKNavigationResponsePolicyCancel);
}

//#pragma mark - KVO回馈
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        self.processLayer.opacity = 1;
        if ([change[@"new"] floatValue] <[change[@"old"] floatValue]) {
            return;
        }
        
        self.processLayer.frame = CGRectMake(0, 64, self.view.frame.size.width*[change[@"new"] floatValue], 3);
        if ([change[@"new"]floatValue] == 1.0) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.processLayer.opacity = 0;
                self.processLayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else if ([keyPath isEqualToString:@"title"]){
        self.title = change[@"new"];
    }
}

@end
