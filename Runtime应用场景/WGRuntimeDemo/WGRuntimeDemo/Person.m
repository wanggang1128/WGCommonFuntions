//
//  Person.m
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//
//runtime方式归解档

#import "Person.h"
#import <objc/message.h>

@implementation Person

//告诉系统（NSKeyedArchiver），归档那些属性
-(void)encodeWithCoder:(NSCoder *)aCoder{
    //记录成员变量个数
    unsigned int count = 0;
    /*
     很多需要传递基本数据类型的指针，这么做是为了改变值，经过下一句代码，count的值为Person中其成员变量的真正数量，在runtime中没有.h和.m之分
     ivars  不是数组，是一个指针，ivars[0]代表指向成员变量Ivar的第0个
     */
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar ivar = ivars[i];
        //拿到成员变量的名字,注意类型
        const char *name = ivar_getName(ivar);
        //把C语言字符串转为OC字符串
        //把OC字符串转为C语言字符串代码为const char *name1 = [nameStr UTF8String];
        NSString *nameStr = [NSString stringWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:nameStr] forKey:nameStr];
    }
    //在runtime中，是没有ARC的，所以有new,create,copy都需要手动释放
    free(ivars);
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i=0; i<count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *nameStr = [NSString stringWithUTF8String:name];
            //解档
            id value = [aDecoder decodeObjectForKey:nameStr];
            //通过KVC设置值
            [self setValue:value forKey:nameStr];
        }
        free(ivars);
    }
    return self;
}

//这样如果属性很多的话还需要一个一个添加，后期新增属性也要修改
//-(void)encodeWithCoder:(NSCoder *)aCoder{
//    [aCoder encodeObject:_name forKey:@"name"];
//    [aCoder encodeInt:_age forKey:@"age"];
//    [aCoder encodeInt:_height forKey:@"height"];
//    [aCoder encodeObject:_school forKey:@"school"];
//}

//这样如果属性很多的话还需要一个一个解档，后期新增属性也要修改
//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super init]) {
//        _name = [aDecoder decodeObjectForKey:@"name"];
//        _age = [aDecoder decodeIntForKey:@"age"];
//        _height = [aDecoder decodeIntForKey:@"height"];
//        _school = [aDecoder decodeObjectForKey:@"school"];
//    }
//    return self;
//}

- (NSString *)msgsendTest:(NSString *)str{
    return [NSString stringWithFormat:@"测试消息发送msgsendTest这是参数:%@", str];
}

@end
