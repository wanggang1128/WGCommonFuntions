//
//  CPerson.m
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//

//这个类用来学习：如何获取对象所有的属性名称和属性值、获取对象所有成员变量名称和变量值、获取对象所有的方法名和方法参数数量。

#import "CPerson.h"
#import <objc/message.h>

@implementation CPerson

- (NSDictionary *)allProperties{
    unsigned int count = 0;
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *pro = property_getName(property);
        NSString *proName = [NSString stringWithUTF8String:pro];
        id proValue = [self valueForKey:proName];
        if (proValue) {
            resultDict[proName] = proValue;
        }else{
            resultDict[proName] = @"属性字典中key对应的值不存在";
        }
    }
    free(properties);
    return resultDict;
}
- (NSDictionary *)allIvars{
    unsigned int count = 0;
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *iva = ivar_getName(ivar);
        NSString *ivaName = [NSString stringWithUTF8String:iva];
        id ivaValue = [self valueForKey:ivaName];
        if (ivaValue) {
            resultDict[ivaName] = ivaValue;
        }else{
            resultDict[ivaName] = @"成员变量字典中key对应的值不存在";
        }
    }
    free(ivars);
    return resultDict;
}
- (NSDictionary *)allMethods{
    unsigned int count = 0;
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL metdsel = method_getName(method);
        const char *metd = sel_getName(metdsel);
        NSString *metdName = [NSString stringWithUTF8String:metd];
        //获取参数个数
        unsigned int arguments = method_getNumberOfArguments(method);
        //其中有两个默认参数，id self, SEL _cmd
        resultDic[metdName] = @(arguments - 2);
    }
    free(methods);
    return resultDic;
}

@end
