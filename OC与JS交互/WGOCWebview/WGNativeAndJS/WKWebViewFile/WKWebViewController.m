//
//  WKWebViewController.m
//  WGNativeAndJS
//
//  Created by wanggang on 2018/4/9.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController ()<WKUIDelegate, WKScriptMessageHandler>
@property (strong, nonatomic) WKWebView *wkWebView;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WKWebviewController";
    [self initWKWebView];
}

- (void)initWKWebView{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    [configuration.userContentController addScriptMessageHandler:self name:@"wg"];
    NSString *webViewURLStr = [[NSBundle mainBundle] pathForResource:@"wkweb.html" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:webViewURLStr];
    [self.wkWebView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"body:%@", message.body);
    if ([message.name isEqualToString:@"wg"]) {
        [self showMessageWithParams:message.body];
    }
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Show Message
- (void)showMessageWithParams:(NSDictionary *)dict {
    
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSString *messageStr = [dict objectForKey:@"message"];
    NSString *titleStr = [dict objectForKey:@"title"];
    NSLog(@"title:%@", titleStr);
    NSLog(@"messageStr:%@", messageStr);
    
    // 将结果返回给js
    NSString *returnJSStr = [NSString stringWithFormat:@"showMessageFromWKWebViewResult('%@')", @"message传到OC成功，message传到OC成功，message传到OC成功，message传到OC成功，message传到OC成功，message传到OC成功"];
    [self.wkWebView evaluateJavaScript:returnJSStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@,%@", result, error);
    }];
}
@end
