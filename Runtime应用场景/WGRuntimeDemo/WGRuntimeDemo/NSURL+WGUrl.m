//
//  NSURL+WGUrl.m
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//
//方法交换

#import "NSURL+WGUrl.h"
#import <objc/message.h>

@implementation NSURL (WGUrl)

+(void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //系统待交换方法
        Method oldMethod = class_getClassMethod([self class], @selector(URLWithString:));
        //准备与系统方法交换的新方法
        Method newMethod = class_getClassMethod([self class], @selector(WG_URLWithString:));
        //这里要加一个判断，在没有实现新方法时，不进行交换
        if (oldMethod && newMethod) {
            method_exchangeImplementations(oldMethod, newMethod);
        }
    });
}

+(instancetype)WG_URLWithString:(NSString *)urlStr{
    if ([urlStr hasPrefix:@"http"]) {
        //注意这里不会导致死循环，因为已经进行了方法交换，所以执行[self WG_URLWithString:urlStr]时相当于执行的是[self URLWithString:urlStr]
        NSURL *url = [self WG_URLWithString:urlStr];
        if (!url) {
            return nil;
        }else{
            return url;
        }
    }else{
        return nil;
    }
}

@end
