//
//  MsgZFPerson.m
//  WGRuntimeDemo
//
//  Created by wanggang on 2018/4/17.
//  Copyright © 2018年 wanggang. All rights reserved.
//

//消息转发

#import "MsgZFPerson.h"
#import <objc/message.h>
#import "Person.h"

@interface MsgZFPerson()

@property (nonatomic, strong) Person *p;

@end

@implementation MsgZFPerson

//第1步

//当调用一个没有实现的类方法
//+(BOOL)resolveClassMethod:(SEL)sel
//调用了未实现的对象方法
+(BOOL)resolveInstanceMethod:(SEL)sel{
    /*
     IMP方法实现，一个函数指针
     下面这么做相当于：只要调用了未实现的对象方法，都会拦截执行commonMethod这个方法。
     当然也可以针对某个方法做实现处理
     */
    class_addMethod([self class], sel, (IMP)commonMethod, "");
    return YES;
//    return NO;
}

//注意：需要传参数的话：前两个参数是默认参数，必填上，后面才跟上自己的参数。如果没有参数，则默认可以不填
id commonMethod(id objc, SEL _cmd, id name){
    /*
     这里如果需要给一个通用提示的话，可以不接受传过来的参数，写成定值
     */
    NSString *className = NSStringFromClass([objc class]);
    NSString *selName = NSStringFromSelector(_cmd);
    return [NSString stringWithFormat:@"%@中%@方法未实现，会导致崩溃",className, selName];
}

//第2步
/*
 在第1步返回NO时。
 Runtime 系统会再给我们一次偷梁换柱的机会，即通过重载下面方法替换消息的接受者为其他对象。
 这里MsgZFPerson并没有msgsendTest:方法，在转发之前把消息接受对象改为了Person，该类有此方法。取消注释的话，消息转发就不会执行了
 */
- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(msgsendTest:)) {
        return self.p;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (Person *)p{
    if (!_p) {
        _p = [[Person alloc] init];
    }
    return _p;
}

//第3步
//如果前两步都没有拦截的话，则可以消息转发，防止崩溃
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(msgsendTest:)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

-(void)forwardInvocation:(NSInvocation *)anInvocation{
    if ([self.p respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:self.p];
    }else{
        [super forwardInvocation:anInvocation];
    }
//    [anInvocation setSelector:@selector(dance:)];
//    [anInvocation invokeWithTarget:self];
}

- (NSString *)dance:(NSString *)str{
    return str;
}



@end
