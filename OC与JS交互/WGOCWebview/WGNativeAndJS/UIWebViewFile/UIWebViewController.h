//
//  UIWebViewController.h
//  WGNativeAndJS
//
//  Created by wanggang on 2018/4/9.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol UIWebViewControllerDelegate <JSExport>
//tianbai对象调用的JavaScript方法，必须声明！！！
- (void)call;
- (void)getCall:(NSString *)callString;

@end

@interface UIWebViewController : UIViewController<UIWebViewDelegate, UIWebViewControllerDelegate>

@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) UIWebView *webView;

@end
