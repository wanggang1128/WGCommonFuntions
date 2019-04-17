//
//  WGMsgSend.m
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//
//这个文件用来测试消息发送

#import "WGMsgSend.h"
#import "Person.h"
#import <objc/message.h>

@implementation WGMsgSend

+ (NSString *)wgMsgSendTest{
    /*
    1、初始化一个对象，并分配内存
    Person *per = [[Person alloc] init];
    return [per msgsendTest:@"我是参数1"];
    */
    
    /*
     2、可以拆分为
    Person *per = [Person alloc];
    [per init];
    return [per msgsendTest:@"我是参数2"];
     */
    
    /*
     3、通过msgsend改写为
     Person *per = objc_msgSend([Person class], @selector(alloc));
     per = objc_msgSend(per, @selector(init));
     return objc_msgSend(per, @selector(msgsendTest:), @"我是参数3");
     */
    
    /*
     4、在3中依然可以看到@selector这种方法，于是可以进一步改成
     */
    Person *per = objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"));
    per = objc_msgSend(per, sel_registerName("init"));
    return objc_msgSend(per, sel_registerName("msgsendTest:"), @"我是参数4");
}

@end
