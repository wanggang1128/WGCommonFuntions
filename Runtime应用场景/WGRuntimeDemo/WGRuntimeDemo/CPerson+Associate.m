//
//  CPerson+Associate.m
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//

//注意：即使在这里看用runtime为分类添加了set和get方法，外界可以通过.语法调用改属性，但是在成员变量列表中依然没有height和associatedCallback，可见在分类里是不能添加成员变量的。

#import "CPerson+Associate.h"
#import <objc/message.h>

@implementation CPerson (Associate)

-(NSNumber *)height{
    return objc_getAssociatedObject(self, @selector(height));
}

-(void)setHeight:(NSNumber *)height{
    objc_setAssociatedObject(self, @selector(height), height, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CodingCallback)associatedCallback{
    return objc_getAssociatedObject(self, @selector(associatedCallback));
}

-(void)setAssociatedCallback:(CodingCallback)associatedCallback{
    objc_setAssociatedObject(self, @selector(associatedCallback), associatedCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
