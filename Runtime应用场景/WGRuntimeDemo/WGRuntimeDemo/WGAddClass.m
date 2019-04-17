//
//  WGAddClass.m
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//

#import "WGAddClass.h"
#import <objc/message.h>

@implementation WGAddClass

- (NSString *)addClassTest{
    Class WGPerson = objc_allocateClassPair([NSObject class], "WGPerson", 0);
    //添加成员变量name,age
    class_addIvar(WGPerson, "_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    class_addIvar(WGPerson, "_age", sizeof(int), log2(sizeof(int)), @encode(int));
    
    //添加实例方法
    SEL method = sel_registerName("say:");
    class_addMethod(WGPerson, method, (IMP)sayFunction, "v@:@");
    
    //注册一个类
    objc_registerClassPair(WGPerson);
    
    //创建类的实例
    id wgp = [[WGPerson alloc] init];
    
    //通过KVC赋值
    [wgp setValue:@"hanjiang" forKey:@"name"];
    //通过从类中获取成员变量_age，再为pepleShare的成员变量赋值
    Ivar ivar = class_getInstanceVariable(WGPerson, "_age");
    object_setIvar(wgp, ivar, @18);
    
    //发送消息
    NSString *str =  objc_msgSend(wgp, method, @"动态添加类，给类添加成员变量，给变量赋值成功");
    
    //当WGPerson类或者它的子类的实例还存在，则不能调用objc_disposeClassPair这个方法；因此这里要先销毁实例对象后才能销毁类；
    wgp = nil;
    //销毁类
    objc_disposeClassPair(WGPerson);
    
    return str;
}

id sayFunction(id objc, SEL _cmd, id some){
    return [NSString stringWithFormat:@"今年%@岁的%@说:%@",object_getIvar(objc, class_getInstanceVariable([objc class], "_age")),[objc valueForKey:@"name"], some];
}

@end
