//
//  ViewController+UnitTest.h
//  TestDemo
//
//  Created by wangshanshan on 17/1/4.
//  Copyright © 2017年 aoke. All rights reserved.

// viewController的扩展类，如果要访问ViewController类里的私有方法和私有属性，则需要在该扩展类里声明相应的方法和属性

#import "ViewController.h"

@interface ViewController (UnitTest)

-(NSInteger)addA:(NSInteger)a b:(NSInteger)b;

@end
