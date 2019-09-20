//
//  NSObject+WG_KVO.m
//  WGRuntimeDemo
//
//  Created by wanggang on 2019/9/20.
//  Copyright © 2019 wanggang. All rights reserved.
//

#import "NSObject+WG_KVO.h"
#import <objc/message.h>

@implementation NSObject (WG_KVO)

-(void)wg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
    //动态添加一个类
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *subClassName = [NSString stringWithFormat:@"WGKVO_%@",oldClassName];
    const char *subCharName = subClassName.UTF8String;
    //定义一个类
    Class subClass = objc_allocateClassPair([self class], subCharName, 0);
    //添加setAge方法
    class_addMethod(subClass, sel_registerName("setAge:"), (IMP)setAge, "v@:i");
    //注册这个类
    objc_registerClassPair(subClass);
    //改变isa指针,让self指向子类
    object_setClass(self, subClass);
    //给对象绑定观察者对象
    objc_setAssociatedObject(self, "observer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//子类重写父类的setAge方法，OC中一般都会先调用[super method],这样如果父类的setAge方法里对age值做过什么处理，子类里面也会做一样的处理，所以在这里，也需要先调用父类的setAge方法
void setAge(id self, SEL _cmd, int age) {
    
    //子类自己
    Class subClass = [self class];
    //父类
    Class supClass = class_getSuperclass(subClass);
    //isa指向父类
    object_setClass(self, supClass);
    //存放age改变之前的值
    NSMutableDictionary *changeDic = [[NSMutableDictionary alloc] init];
    unsigned int oldCount = 0;
    //由于已经让self指向了自己的父类，所以在取属性的时候，可以直接用[self class]拿到age
    Ivar *ivars = class_copyIvarList([self class], &oldCount);
    
    for (int i = 0; i < oldCount; i++) {
        
        Ivar ivar = ivars[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:ivarName];
        if ([name isEqualToString:@"_age"]) {
            
            [changeDic setValue:[self valueForKey:name] forKey:[NSString stringWithFormat:@"old%@",name]];
        }
    }
    free(ivars);
    
    //调用父类的setAge方法,类似于OC的[super setAge:age]
    objc_msgSend(self, @selector(setAge:), age);
    
    //执行完[super setAge:age],之后让isa继续指向子类
    object_setClass(self, subClass);
    //已经让self指向了自己，所以如果还是直接用[self class]的话是拿不到age属性的，因为age是父类的，并且现在这个子类的属性列表为空，容易在取值的时候造成崩溃，所以用superClass
    unsigned int newCount = 0;
    Ivar *newIvars = class_copyIvarList(supClass, &newCount);
    for (int i = 0; i < newCount; i++) {
        
        Ivar ivar = newIvars[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:ivarName];
        if ([name isEqualToString:@"_age"]) {
            
            [changeDic setValue:[self valueForKey:name] forKey:[NSString stringWithFormat:@"new%@",name]];
        }
    }
    free(newIvars);
    
    //通知外界
    id observer = objc_getAssociatedObject(self, "observer");
    
    //指向父类
    object_setClass(self, supClass);
    [observer wg_observeValueForKeyPath:@"age" ofObject:self change:changeDic context:nil];
}

@end
